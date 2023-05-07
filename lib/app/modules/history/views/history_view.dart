import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.fetchCompletedTask();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Completed Task'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: GetBuilder(
          init: controller,
          initState: (_) {},
          builder: (_) {
            return controller.completedTaskList.isEmpty
                ? const Center(
                    child: Text("There is no completed task", style: TextStyle(
                      fontSize: 25,
                    ),),
                  )
                : ListView.separated(
                    // controller: controller.scrollController,
                    itemCount: controller.completedTaskList.length,
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
                              Text(controller.completedTaskList[index].taskName,
                                  style: const TextStyle(
                                    fontSize: 22,
                                  )),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Time Frame",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    "${controller.completedTaskList[index].startTime} - ${controller.completedTaskList[index].startTime}",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              Column(
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
                                        controller
                                            .completedTaskList[index].dueDate
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
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Description: ${controller.completedTaskList[index].description.trim()}",
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  OutlinedButton.icon(
                                      style: OutlinedButton.styleFrom(
                                          minimumSize:
                                              Size(Get.width * 0.4, 40)),
                                      onPressed: () {
                                        Get.toNamed('./create-task',
                                            arguments: {
                                              'task': controller
                                                  .completedTaskList[index]
                                            });
                                      },
                                      icon: const Icon(Icons.refresh),
                                      label: const Text(
                                        "Reschedule",
                                        style: TextStyle(fontSize: 18),
                                      )),
                                  OutlinedButton.icon(
                                      style: OutlinedButton.styleFrom(
                                          minimumSize:
                                              Size(Get.width * 0.4, 40)),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title:
                                                  const Text("Are You Sure?"),
                                              content: const Text(
                                                  "Want To Delete This Task"),
                                              actions: [
                                                ElevatedButton(
                                                  onPressed: () => Get.back(),
                                                  child: const Text("No"),
                                                ),
                                                OutlinedButton(
                                                  onPressed: () =>
                                                      controller.deleteTask(
                                                          task: controller
                                                                  .completedTaskList[
                                                              index]),
                                                  child: const Text("Yes"),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                        controller.deleteTask(
                                            task: controller
                                                .completedTaskList[index]);
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                      ),
                                      label: const Text(
                                        "Delete",
                                        style: TextStyle(fontSize: 18),
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
