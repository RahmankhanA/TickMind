import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ticmind/app/core/local_db/task_hive_model.dart';
import 'package:ticmind/app/modules/home/controllers/home_controller.dart';
import 'package:ticmind/app/modules/main/controllers/main_controller.dart';
// import 'package:ticmind/app/modules/createTask/models/task_model.dart' as Task;

class CreateTaskController extends GetxController {
MainController mainController=Get.find<MainController>();
  final formKey = GlobalKey<FormState>();
  TextEditingController taskNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();

  late var taskBox;
  late var categoryBox;
  var selectedCategoryIndex= 19999.obs;

  List<String> categoryList = [
    'Work',
    'Personal',
    'Fitness/health',
    'Financial',
    'Education',
    'Social',
    'Travel',
    'Creative',
    'Maintenance',
    'Miscellaneous',
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
    super.onClose();
  }
  // Adding a new task

  Future addUser({required TaskModel task}) async {
    await taskBox.put(task.uuid, task);

    log(taskBox.values.toList().toString());

    // taskBox.pzz
    mainController.taskList.add(task);
    mainController.update();
    Get.back();
  }

  void initializeCategory() async {
    // categoryBox.clear();
    //  276228

    if (categoryBox.keys.length == 0) {
      for (var element in categoryList) {
        await categoryBox.add(element);
      }
      // return;
    } else if (categoryBox.keys.length > categoryList.length) {
      categoryList = categoryBox.values as List<String>;
    }
// // categoryBox.deleteAt(2);
//       log(categoryBox.values.length.toString());
    log(categoryBox.values.toString());
    log(categoryBox.keys.toString());
    log(categoryBox.keys.length.toString());
    // log(categoryList.toString());
  }

  void addCategory({required String category}) async {
    if (categoryList.contains(category)) {
      // category already exist
      return;
    }
    categoryBox.add(category);

    // log(categoryBox.keys.toString());
    // log(categoryBox.values.toString());
  }
}
