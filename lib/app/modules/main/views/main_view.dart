import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home '),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.notifications_outlined,
              size: 35,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
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
                    // const SizedBox(
                    //   height: 8,
                    // ),
                    GetBuilder(
                      init: controller,
                      initState: (_) {},
                      builder: (_) {
                        return Text(
                          "${controller.taskList.length} Task",
                          style: const TextStyle(fontSize: 15),
                        );
                      },
                    ),

                    SizedBox(
                      width: 250.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("Progress"),
                              Text("50%"),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                                10), // set the border radius
                            child: const LinearProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.blue),
                              backgroundColor: Colors.grey,
                              minHeight: 8.0,
                              value: .5,
                              semanticsLabel: "50%",
                              semanticsValue: "50%",
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
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Today's Task",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "See All",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
              child: GetBuilder(
                init: controller,
                initState: (_) {},
                builder: (_) {
                  return ListView.builder(
                    itemCount: controller.taskList.length,
                    dragStartBehavior: DragStartBehavior.down,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(controller.taskList[index].category),
                          subtitle: Text(
                            "${controller.taskList[index].startTime} - ${controller.taskList[index].endTime}",
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios),
                        ),
                      );
                    },
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
