import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:ticmind/app/modules/createTask/models/task_model.dart';
import 'package:ticmind/app/core/local_db/task_hive_model.dart';

class MainController extends GetxController {
  List<TaskModel> taskList = [];
  List<Map<String, List<TaskModel>>> todayTaskList = [];
  RxInt totalTodayTask=0.obs;

  late var taskBox;
  @override
  void onInit() async {
    taskBox = await Hive.openBox('taskBox');
    super.onInit();
    // log(taskBox.values.toList().toString());
    //  taskList=   taskBox.values as List<TaskModel>;
    await fetchtask();
    loadTodayTask();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    // to free up space
    Hive.box('taskBox').compact();

    // close all the open boxes before closing the page.
    Hive.close();
    super.onClose();
  }

  Future<void> fetchtask() async {
    var data = await taskBox.values.toList();
    for (TaskModel element in data) {
      taskList.add(element);
    }
    update();
  }

  void loadTodayTask() {
    totalTodayTask.value=0;
    todayTaskList.clear();
    DateTime today = DateTime.parse(DateTime.now().toString().split(" ")[0]);
    for (TaskModel task in taskList) {
      // log(task.dueDate.toString());
      if (task.dueDate == today) {
        totalTodayTask.value++;
        bool isCategoryExist = false;
        Map<String, List<TaskModel>> value = {};
        for (Map<String, List<TaskModel>> element in todayTaskList) {
          if (element.keys.first == task.category) {
            isCategoryExist = true;
            value = element;
          }
        }
        if (isCategoryExist) {
          var index = todayTaskList.indexOf(value);
          todayTaskList[index][task.category]!.add(task);
        } else {
          Map<String, List<TaskModel>> data = {
            task.category:
            [task]
          } ;
          todayTaskList.add(data);
        }
        // todayTaskList.add(task);
      }
    }
  }
}
