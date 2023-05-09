import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ticmind/app/core/local_db/task_hive_model.dart';
import 'package:ticmind/app/core/services/notification_service.dart';
import 'package:ticmind/app/modules/main/controllers/main_controller.dart';
// import 'package:ticmind/app/modules/createTask/models/task_model.dart' as Task;

class CreateTaskController extends GetxController {
  MainController mainController = Get.find<MainController>();
  // CategoryDetailsController categoryDetailsController =
  //     Get.find<CategoryDetailsController>();
  final formKey = GlobalKey<FormState>();
  final addCategoryFormKey = GlobalKey<FormState>();
  TextEditingController taskNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();

  late var taskBox;
  late var categoryBox;
  var selectedCategoryIndex = 19999.obs;
  bool isUpdate = false;
  List<String> categoryList = [];
  List<String> categoryList2 = [
    'Professional',
    'Personal',
    'Financial',
    'Education',
    'Social',
    // 'Travel',
    // 'Creative',
    // 'Maintenance',
    // 'Miscellaneous',
  ];

  late TaskModel task;
  NotificationService notificationService = NotificationService();

  @override
  void onInit() async {
    notificationService.initializeNotifications();
    taskBox = await Hive.openBox('taskBox');
    categoryBox = await Hive.openBox('category');
    super.onInit();

    await initializeCategory();
    try {
      task = Get.arguments['task'];
      isUpdate = true;
      taskNameController.text = task.taskName;
      descriptionController.text = task.description;
      dateController.text = task.dueDate.toString().split(' ').first;
      startTimeController.text = task.startTime;
      endTimeController.text = task.endTime;
      selectedCategoryIndex.value = categoryList.indexOf(task.category);
      log(categoryList.indexOf(task.category).toString());
      log(task.category);
    } catch (error) {
      log(error.toString());
    }
  }

  @override
  void onClose() {
    Hive.box('taskBox').compact();
    Hive.box('category').compact();

    taskNameController.dispose();
    dateController.dispose();
    descriptionController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    super.onClose();
  }
  // Adding a new task

  Future addTask({required TaskModel task}) async {
    await taskBox.put(task.uuid, task);

    // taskBox.pzz
    isUpdate
        ? await mainController.fetchtask()
        : mainController.taskList.add(task);
    mainController.loadTodayTask();
    mainController.update();
    // set notification
    int id = int.parse(task.uuid!.split('-').first.numericOnly(), radix: 10);

    String formated24HourTime = convertTimeTo24HourFormat(task.startTime);
    DateTime notificationTime = task.dueDate.copyWith(
        hour: int.parse(formated24HourTime.split(':').first),
        minute: int.parse(formated24HourTime.split(':')[1]));
    notificationService.scheduleNotification(
        title: task.taskName,
        body: task.description,
        time: notificationTime,
        id: id);

    log("notification scheduled at $notificationTime");
    Get.back();
  }

  String convertTimeTo24HourFormat(String time) {
    final format = DateFormat.jm(); // Create 12-hour time format
    final dateTime = format.parse(time); // Parse time string to DateTime object
    final newFormat = DateFormat('HH:mm'); // Create 24-hour time format
    final formattedTime =
        newFormat.format(dateTime); // Format time to 24-hour format
    return formattedTime;
  }

  Future<void> initializeCategory() async {
    // categoryBox.clear();
    //  276228

    if (categoryBox.keys.length == 0) {
      for (var element in categoryList2) {
        await categoryBox.add(element);
      }
      // return;
    } else if (categoryBox.keys.length != categoryList.length) {
      // categoryList = categoryBox.values as List<String>;
      for (String category in categoryBox.values) {
        categoryList.add(category);
        // log(category);
      }
    } else {
      categoryList = categoryList2;
    }
// // categoryBox.deleteAt(2);
//       log(categoryBox.values.length.toString());
    // log(categoryBox.values.toString());
    // log(categoryBox.keys.toString());
    // log(categoryBox.keys.length.toString());
    update();
    // log(categoryList.toString());
  }

  void addCategory({required String category}) async {
    if (categoryList.contains(category)) {
      // category already exist
      return;
    }
    categoryBox.add(category);
    categoryList.add(category);
    update();

    // log(categoryBox.keys.toString());
    // log(categoryBox.values.toString());
  }

  void deleteCategory({required int index, required String category}) async {
    // if (categoryList.contains(category)) {
    //   // category already exist
    //   // categoryBox.deleteAt(index);
    //   categoryBox.delete(category);
    //   // return;
    // }
    categoryBox.clear();
    Get.snackbar("Deleted", "${categoryList[index]} deleted",
        backgroundColor: Colors.redAccent, snackPosition: SnackPosition.BOTTOM);
    log(" total category ${categoryBox.keys.length}");
    categoryList.removeAt(index);
    update();
    for (var element in categoryList) {
      await categoryBox.add(element);
    }
    // log(categoryBox.keys.toString());
    // log(categoryBox.values.toString());
  }

  validateStartTime() {
    var time = convertTimeTo24HourFormat(startTimeController.text).split(":");
    var now = DateTime.now();
    bool conditionForToday =
        dateController.text == now.toString().split(" ").first;
    log(conditionForToday.toString());
    if (conditionForToday) {
      if (int.parse(time.first) > now.hour) {
        return null;
      } else if (int.parse(time.first) < now.hour) {
        return 'time must be later of currentTime';
      } else if (int.parse(time.first) == now.hour &&
          int.parse(time.last) < now.minute) {
        return 'time must be later of currentTime';
      }
    }
    return null;
  }

  validateEndTime() {
    var endTime = convertTimeTo24HourFormat(endTimeController.text).split(":");
    var startTime =
        convertTimeTo24HourFormat(startTimeController.text).split(":");
    var now = DateTime.now();
    bool conditionForToday =
        dateController.text == now.toString().split(" ").first;
    log(conditionForToday.toString());
    if (conditionForToday) {
      if (int.parse(endTime.first) < now.hour) {
        return 'time must be later of currentTime';
      } else if (int.parse(endTime.first) == now.hour &&
          int.parse(endTime.last) < now.minute) {
        return 'time must be later of currentTime';
      } else if (int.parse(endTime.first) < int.parse(startTime.first)) {
        return 'endTime must be greater that start time';
      }
      return null;
    }
    if (int.parse(endTime.first) < int.parse(startTime.first)) {
      return 'endTime must be greater that start time';
    }

    return null;
  }
}
