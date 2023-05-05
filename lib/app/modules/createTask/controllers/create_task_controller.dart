import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ticmind/app/core/local_db/task_hive_model.dart';
import 'package:ticmind/app/modules/main/controllers/main_controller.dart';
// import 'package:ticmind/app/modules/createTask/models/task_model.dart' as Task;

class CreateTaskController extends GetxController {
  MainController mainController = Get.find<MainController>();
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
  @override
  void onInit() async {
    taskBox = await Hive.openBox('taskBox');
    categoryBox = await Hive.openBox('category');
    super.onInit();

    initializeCategory();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    // to free up space
    Hive.box('taskBox').compact();
    Hive.box('category').compact();
    // close all the open boxes before closing the page.
    Hive.close();
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
    mainController.taskList.add(task);
    mainController.loadTodayTask();
    mainController.update();
    Get.back();
  }

  void initializeCategory() async {
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
        log(category);
      }
    } else {
      categoryList = categoryList2;
    }
// // categoryBox.deleteAt(2);
//       log(categoryBox.values.length.toString());
    log(categoryBox.values.toString());
    log(categoryBox.keys.toString());
    log(categoryBox.keys.length.toString());
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
}
