import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:ticmind/app/modules/createTask/models/task_model.dart';
import 'package:ticmind/app/core/local_db/task_hive_model.dart';

class MainController extends GetxController {
  List<TaskModel> taskList = [];

  late var taskBox;
  @override
  void onInit() async {
    taskBox = await Hive.openBox('taskBox');
    super.onInit();
    // log(taskBox.values.toList().toString());
    //  taskList=   taskBox.values as List<TaskModel>;
   fetchtask();
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

  void fetchtask() async{
     var data = await taskBox.values.toList();
    for (TaskModel element in data) {
      taskList.add(element);
    }
    update();
  }
}
