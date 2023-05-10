import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticmind/app/modules/widgets/emptry_task.dart';

import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home '),
        // elevation: 5,
        centerTitle: true,
        // actions: const [
        //   Padding(
        //     padding: EdgeInsets.all(8.0),
        //     child: Icon(
        //       Icons.notifications_outlined,
        //       size: 35,
        //     ),
        //   )
        // ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.17,
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(30), // sets the rounded corners
                color: Theme.of(context).cardColor,

                // gradient: LinearGradient(colors: [
                //   Theme.of(context).cardColor,
                //   Theme.of(context).primaryColor,
                //   Theme.of(context).cardColor,
                // ]),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Today's Progress Summary",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),

                    Obx(() => Text(
                          "${controller.totalTodayTask.value} Task",
                          style: const TextStyle(fontSize: 15),
                        )),

                    SizedBox(
                      width: 250.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Progress"),
                              Obx(() => Text(controller
                                          .todayCompletedTask.value ==
                                      0
                                  ? '0%'
                                  : "${(controller.todayCompletedTask.value / controller.totalTodayTask.value * 100).round()}%")),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                                10), // set the border radius
                            child: Obx(
                              () => LinearProgressIndicator(
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    Colors.blue),
                                backgroundColor: Colors.grey,
                                minHeight: 8.0,
                                value: controller.todayCompletedTask.value == 0
                                    ? 0
                                    : controller.todayCompletedTask.value /
                                        controller.totalTodayTask.value,
                                // semanticsLabel: "50%",
                                // semanticsValue: "50%",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // const SizedBox(width: 200.0, child: LinearProgressBar()),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Today's Task",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
                TextButton(
                  onPressed: () {
                    // Get.to(()=>CategoryDetailsPage(category: "All", taskList: controller.taskList));
                    Get.toNamed('./category-details', arguments: {
                      'category': "All",
                      'taskList': controller.taskList
                    });
                  },
                  child: const Text(
                    "See All",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.52,
              child: GetBuilder(
                init: controller,
                initState: (_) {},
                builder: (_) {
                  return Visibility(
                    replacement: const EmptyTaskWidget(isTextVisible: true,),
                    visible: controller.todayTaskList.isNotEmpty,
                    child: ListView.builder(
                      itemCount: controller.todayTaskList.length,
                      dragStartBehavior: DragStartBehavior.down,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            onTap: () {
                              // Get.to(() => CategoryDetailsPage(
                              //     category:
                              //         controller.todayTaskList[index].keys.first,
                              //     taskList: controller
                              //         .todayTaskList[index].values.first));

                              Get.toNamed('./category-details', arguments: {
                                'category':
                                    controller.todayTaskList[index].keys.first,
                                'taskList':
                                    controller.todayTaskList[index].values.first
                              });
                            },
                            title: Text(
                                controller.todayTaskList[index].keys.first),
                            subtitle: Text(
                              "${controller.todayTaskList[index].values.first.first.startTime} - ${controller.todayTaskList[index].values.first.first.endTime}",
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}
