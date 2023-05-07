import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ticmind/app/core/local_db/task_hive_model.dart';
import 'package:ticmind/app/modules/main/controllers/main_controller.dart';

class HistoryController extends GetxController {
  MainController mainController = Get.find<MainController>();

  List<TaskModel> completedTaskList = [];
  var taskBox;

  @override
  void onInit() async {
    fetchCompletedTask();
    taskBox = await Hive.openBox('taskBox');
    super.onInit();
  }

  void fetchCompletedTask() {
    completedTaskList.clear();
    for (TaskModel task in mainController.taskList) {
      if (task.isCompleted) {
        completedTaskList.add(task);
      }
    }
  }

  void deleteTask({required TaskModel task}) {
    taskBox.delete(task.uuid);
    completedTaskList.remove(task);
    mainController.taskList.remove(task);
    Get.back();
    update();
    Get.snackbar("Deleted", "${task.taskName} deleted",
        backgroundColor: Colors.redAccent, snackPosition: SnackPosition.BOTTOM);
  }
}
