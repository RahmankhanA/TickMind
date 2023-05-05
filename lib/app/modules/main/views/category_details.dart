// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:ticmind/app/core/local_db/task_hive_model.dart';

class CategoryDetailsPage extends StatelessWidget {
  final String category;
  final List<TaskModel> taskList;
  const CategoryDetailsPage({
    Key? key,
    required this.category,
    required this.taskList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("$category  Task"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Stack(
            children: [
              ListView.separated(
                itemCount: taskList.length,
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Text(
                            taskList[index].taskName,
                            style: const TextStyle(fontSize: 22),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Time Frame",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                "${taskList[index].startTime} - ${taskList[index].startTime}",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          Visibility(
                            visible: category == 'All',
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Date",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      taskList[index]
                                          .dueDate
                                          .toString()
                                          .split(" ")
                                          .first
                                          .replaceAll("-", "/"),
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Description: ${taskList[index].description.trim()}",
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              OutlinedButton.icon(
                                  style: OutlinedButton.styleFrom(
                                      minimumSize: Size(Get.width * 0.4, 40)),
                                  onPressed: () {},
                                  icon: const Icon(Icons.edit),
                                  label: const Text(
                                    "Edit Task",
                                    style: TextStyle(fontSize: 18),
                                  )),
                              OutlinedButton.icon(
                                  style: OutlinedButton.styleFrom(
                                      minimumSize: Size(Get.width * 0.4, 40)),
                                  onPressed: () {},
                                  icon: const Icon(Icons.done),
                                  label: const Text(
                                    "Complete",
                                    style: TextStyle(fontSize: 18),
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(Get.width * 0.6, 50)),
                  onPressed: () => Get.offNamed('./create-task'),
                  // icon: const Icon(Icons.add,size: 25,),
                  child: const Text("Add Task", style: TextStyle(
                    fontSize: 20
                  ),),
                ),
              )
            ],
          ),
        ));
  }
}
