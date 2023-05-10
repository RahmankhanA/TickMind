import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ticmind/app/core/local_db/task_hive_model.dart';
import 'package:ticmind/app/modules/main/controllers/main_controller.dart';

class CategoryDetailsController extends GetxController {
  String category = '';
  List<TaskModel> taskList = [];
  List<TaskModel> taskListDuplicate = [];
  MainController mainController = Get.find<MainController>();

  bool isSearchBarVisible = true;

  ScrollController scrollController = ScrollController();

  var taskBox;
  final count = 0.obs;
  @override
  void onInit() async {
    category = Get.arguments['category'];
    taskList = Get.arguments['taskList'];
    taskListDuplicate = [...taskList];
    sortTask();
    taskBox = await Hive.openBox('taskBox');
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.dispose();
  }

  filter(String searchTerm) {
    taskListDuplicate.clear();
    log(taskList.length.toString());
    for (var element in taskList) {
      log(element.taskName
          .toLowerCase()
          .contains(searchTerm.toLowerCase())
          .toString());
      if (element.taskName.toLowerCase().contains(searchTerm.toLowerCase())) {
        taskListDuplicate.add(element);
      }
    }
    update();
  }

  listenScrollNotification({required ScrollNotification scrollNotification}) {
    if (scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      isSearchBarVisible = false;
    } else if (scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      isSearchBarVisible = true;
      //setState function
    }
    update();

    return true;
  }

  void completeTask({required int index}) async {
    taskListDuplicate[index].isCompleted = true;
    var data = taskListDuplicate[index];
    int newIndex = taskList.indexOf(data);
    taskList[newIndex].isCompleted = true;
    update();
    await taskBox.put(data.uuid, data);
    await mainController.fetchtask();
    mainController.loadTodayTask();
  }

  void unCompleteTask({required int index}) async {
    taskListDuplicate[index].isCompleted = false;
    var data = taskListDuplicate[index];
    int newIndex = taskList.indexOf(data);
    taskList[newIndex].isCompleted = false;
    update();
    await taskBox.put(data.uuid, data);
    await mainController.fetchtask();
    mainController.loadTodayTask();
  }

  void sortTask() {}
}
