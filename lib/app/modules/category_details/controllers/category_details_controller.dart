import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:ticmind/app/core/local_db/task_hive_model.dart';

class CategoryDetailsController extends GetxController {
  String category = '';
  List<TaskModel> taskList = [];
  List<TaskModel> taskListDuplicate = [];

  bool isSearchBarVisible = true;

  ScrollController scrollController = ScrollController();

  final count = 0.obs;
  @override
  void onInit() {
    category = Get.arguments['category'];
    taskList = Get.arguments['taskList'];
    taskListDuplicate = [...taskList];
    scrollController.addListener(() {
// log(scrollController.)
    });
    super.onInit();
  }

  @override
  void onDispose() {
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
}
