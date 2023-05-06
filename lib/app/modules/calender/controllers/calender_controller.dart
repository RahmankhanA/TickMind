import 'dart:developer';

import 'package:get/get.dart';
import 'package:ticmind/app/core/local_db/task_hive_model.dart';
import 'package:ticmind/app/modules/main/controllers/main_controller.dart';

class CalenderController extends GetxController {
  DateTime selectedDay = DateTime.now();
  MainController mainController = Get.find<MainController>();
  List<Map<String, List<TaskModel>>> selectedDayTaskList = [];
  List<DateTime> taskDayList=[]; // day where task is added

  @override
  void onInit() {
    super.onInit();
    getTaskListOfSelectedDay(day: DateTime.now());
  }

  // void getTaskListOfSelectedDay({required DateTime day}) {
  //   selectedDayTaskList.clear();
  //   DateTime today = DateTime.parse(day.toString().split(" ")[0]);
  //   log(today.toString());
  //   for (TaskModel task in mainController.taskList) {
  //     // log(task.toString());
  //     if (task.dueDate == today) {
  //       selectedDayTaskList.add(task);
  //     }
  //   }
  //   update();
  // }
  void getTaskListOfSelectedDay({required DateTime day}) {
    // log(day.toString());
    selectedDayTaskList.clear();
    DateTime today = DateTime.parse(day.toString().split(" ")[0]);
    for (TaskModel task in mainController.taskList) {
      // log(task.dueDate.toString());
      taskDayList.add(task.dueDate);
      if (task.dueDate == today) {
        bool isCategoryExist = false;
        Map<String, List<TaskModel>> value = {};
        for (Map<String, List<TaskModel>> element in selectedDayTaskList) {
          if (element.keys.first == task.category) {
            isCategoryExist = true;
            value = element;
          }
        }
        if (isCategoryExist) {
          var index = selectedDayTaskList.indexOf(value);
          selectedDayTaskList[index][task.category]!.add(task);
        } else {
          Map<String, List<TaskModel>> data = {
            task.category: [task]
          };
          selectedDayTaskList.add(data);
        }
        // todayTaskList.add(task);
      }
    }
    update();
  }
}
