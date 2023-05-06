import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/category_details_controller.dart';

class CategoryDetailsView extends GetView<CategoryDetailsController> {
  const CategoryDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${controller.category}  Task"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            // SizedBox(
            //   height: 50,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            GetBuilder(
              init: controller,
              initState: (_) {},
              builder: (_) {
                return Visibility(
                  replacement: const SizedBox(
                    height: 0,
                  ),
                  visible: controller.isSearchBarVisible,
                  child: Column(
                    children: [
                      SizedBox(
                        width: Get.width * 0.8,
                        height: 55,
                        child: TextFormField(
                          decoration: InputDecoration(
                              fillColor: Theme.of(context).scaffoldBackgroundColor,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).iconTheme.color!),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Theme.of(context).iconTheme.color!),
                              ),
                              suffixIcon: Icon(
                                Icons.search_outlined,
                                color: Theme.of(context).primaryColor,
                              ),
                              hintText: "Start Typing"),
                          onChanged: (value) {
                            controller.filter(value);
                          },
                        ),
                      ),
                       const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                );
              },
            ),
            

            Flexible(
              child: Stack(
                children: [
                  GetBuilder(
                    init: controller,
                    initState: (_) {},
                    builder: (_) {
                      return NotificationListener<ScrollNotification>(
                        onNotification: (notification) =>
                            controller.listenScrollNotification(
                                scrollNotification: notification),
                        child: ListView.separated(
                          controller: controller.scrollController,
                          itemCount: controller.taskListDuplicate.length,
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
                                      controller
                                          .taskListDuplicate[index].taskName,
                                      style: const TextStyle(fontSize: 22),
                                    ),
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
                                          "${controller.taskListDuplicate[index].startTime} - ${controller.taskListDuplicate[index].startTime}",
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    Visibility(
                                      visible: controller.category == 'All',
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
                                                controller
                                                    .taskListDuplicate[index]
                                                    .dueDate
                                                    .toString()
                                                    .split(" ")
                                                    .first
                                                    .replaceAll("-", "/"),
                                                style: const TextStyle(
                                                    fontSize: 16),
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
                                      "Description: ${controller.taskListDuplicate[index].description.trim()}",
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
                                            onPressed: () {},
                                            icon: const Icon(Icons.edit),
                                            label: const Text(
                                              "Edit Task",
                                              style: TextStyle(fontSize: 18),
                                            )),
                                        OutlinedButton.icon(
                                            style: OutlinedButton.styleFrom(
                                                minimumSize:
                                                    Size(Get.width * 0.4, 40)),
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
                      child: const Text(
                        "Add Task",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
