// import 'package:ticmind/app/modules/createTask/models/task_model.dart';

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticmind/app/core/custom_validation.dart';
import 'package:ticmind/app/core/local_db/task_hive_model.dart';
import 'package:ticmind/app/modules/createTask/widgets/title_text.dart';
import 'package:uuid/uuid.dart';

import '../controllers/create_task_controller.dart';

class CreateTaskView extends GetView<CreateTaskController> {
  const CreateTaskView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Create New Task',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18).copyWith(top: 20),
          child: SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitleText(title: 'Task Name'),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: controller.taskNameController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => CustomValidation.basicValidation(
                        value: value!, fieldName: "Task Name"),
                    maxLength: 25,
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
                        hintText: "UI Design"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const TitleText(title: 'Category'),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 50,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.categoryList.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(width: 10);
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return Obx(() => Card(
                              // color: Theme.of(context).primaryColor,
                              color: controller.selectedCategoryIndex.value ==
                                      index
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).cardColor,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 8.0),
                                child: Center(
                                    child: GestureDetector(
                                  onTap: () => controller
                                      .selectedCategoryIndex.value = index,
                                  child: Text(
                                    controller.categoryList[index],
                                    style: const TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                )),
                              ),
                            ));
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const TitleText(title: 'Date & Time'),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: controller.dateController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (controller.dateController.text == 'null') {
                        return "date is Required";
                      }
                      return null;
                    },
                    readOnly: true,
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
                        Icons.calendar_month,
                        color: Theme.of(context).primaryColor,
                      ),
                      hintText: "Select Date",
                    ),
                    onTap: () async {
                      // showDialog(
                      //   context: context,
                      //   builder: (context) {
                      //     return AlertDialog(
                      //       content: SizedBox(
                      //         height: 100,
                      //         width: MediaQuery.of(context).size.width,
                      //         child: CalenderPicker(
                      //           DateTime.now(),
                      //           initialSelectedDate: DateTime.now(),
                      //           selectionColor: Colors.black,
                      //           selectedTextColor: Colors.white,
                      //           // monthTextStyle: ,
                      //           monthTextStyle: const TextStyle(
                      //               fontSize: 20,
                      //               color: Colors.red,
                      //               backgroundColor: Colors.blue),
                      //           onDateChange: (date) {
                      //             // New date selected
                      //             controller.dateController.text =
                      //                 date.toString();
                      //           },
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // );'
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(), //get today's date
                          firstDate: DateTime(
                              2000), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101));
                      // CalenderPicker(
                      //   DateTime.now(),
                      //   initialSelectedDate: DateTime.now(),
                      //   selectionColor: Colors.black,
                      //   selectedTextColor: Colors.white,
                      //   onDateChange: (date) {
                      //     // New date selected
                      //   },
                      // );
                      controller.dateController.text =
                          pickedDate.toString().split(" ")[0];
                      log("calender clicked");
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TitleText(
                              title: 'Start Time',
                              fontWeight: FontWeight.w500,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: controller.startTimeController,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              readOnly: true,
                              // validator: (value) =>
                              //     CustomValidation.descriptionValidation(
                              //         value: value!, fieldName: "description"),
                              decoration: InputDecoration(
                                  fillColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Theme.of(context).iconTheme.color!),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                        color:
                                            Theme.of(context).iconTheme.color!),
                                  ),
                                  suffixIcon: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  hintText:
                                      "${TimeOfDay.now().hour}: ${TimeOfDay.now().minute}"),
                              onTap: () async {
                                TimeOfDay? pickedTime = await showTimePicker(
                                  helpText: "Select Start Time",
                                  initialTime: TimeOfDay.now(),
                                  context: context, //context of current state
                                );

                                if (pickedTime != null) {
                                  // ignore: use_build_context_synchronously
                                  controller.startTimeController.text =
                                      pickedTime
                                          .format(context); //output 10:51 PM
                                  // DateTime parsedTime = DateFormat.jm().parse(
                                  //     pickedTime.format(context).toString());
                                  // //converting to DateTime so that we can further format on different pattern.
                                  // print(
                                  //     parsedTime); //output 1970-01-01 22:53:00.000
                                  // String formattedTime =
                                  //     DateFormat('HH:mm:ss').format(parsedTime);
                                  // print(formattedTime); //output 14:59:00
                                  //DateFormat() is from intl package, you can format the time on any pattern you need.
                                } else {
                                  print("Time is not selected");
                                }
                              },

                              // maxLines: 10,
                              // minLines: 2,
                              // maxLength: 200,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TitleText(
                              title: 'End Time',
                              fontWeight: FontWeight.w500,
                            ),
                            const SizedBox(
                              height: 10,
                            ),

                            TextFormField(
                              controller: controller.endTimeController,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              readOnly: true,
                              // validator: (value) =>
                              //     CustomValidation.descriptionValidation(
                              //         value: value!, fieldName: "description"),
                              decoration: InputDecoration(
                                  fillColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Theme.of(context).iconTheme.color!),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                        color:
                                            Theme.of(context).iconTheme.color!),
                                  ),
                                  suffixIcon: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  hintText:
                                      "${TimeOfDay.now().hour}: ${TimeOfDay.now().minute}"),
                              onTap: () async {
                                TimeOfDay? pickedTime = await showTimePicker(
                                  helpText: "Select End Time",
                                  initialTime: TimeOfDay.now(),
                                  context: context, //context of current state
                                );

                                if (pickedTime != null) {
                                  // ignore: use_build_context_synchronously
                                  controller.endTimeController.text = pickedTime
                                      .format(context); //output 10:51 PM
                                  // DateTime parsedTime = DateFormat.jm().parse(
                                  //     pickedTime.format(context).toString());
                                  // //converting to DateTime so that we can further format on different pattern.
                                  // print(
                                  //     parsedTime); //output 1970-01-01 22:53:00.000
                                  // String formattedTime =
                                  //     DateFormat('HH:mm:ss').format(parsedTime);
                                  // print(formattedTime); //output 14:59:00
                                  //DateFormat() is from intl package, you can format the time on any pattern you need.
                                } else {
                                  print("Time is not selected");
                                }
                              },

                              // maxLines: 10,
                              // minLines: 2,
                              // maxLength: 200,
                            ),

                            // DropdownButtonFormField(
                            //   icon: Icon(
                            //     Icons.keyboard_arrow_down,
                            //     color: Theme.of(context).primaryColor,
                            //   ),
                            //   decoration: InputDecoration(
                            //     fillColor:
                            //         Theme.of(context).scaffoldBackgroundColor,
                            //     border: OutlineInputBorder(
                            //       borderRadius: BorderRadius.circular(15),
                            //       borderSide: BorderSide(
                            //           color:
                            //               Theme.of(context).iconTheme.color!),
                            //     ),
                            //     focusedBorder: OutlineInputBorder(
                            //       borderRadius: BorderRadius.circular(15),
                            //       borderSide: BorderSide(
                            //           color:
                            //               Theme.of(context).iconTheme.color!),
                            //     ),
                            //     enabledBorder: OutlineInputBorder(
                            //       borderRadius: BorderRadius.circular(15),
                            //       borderSide: BorderSide(
                            //           color:
                            //               Theme.of(context).iconTheme.color!),
                            //     ),
                            //   ),
                            //   items: const [
                            //     DropdownMenuItem(
                            //       value: 2,
                            //       child: Text("4"),
                            //     ),
                            //     DropdownMenuItem(
                            //       value: 3,
                            //       child: Text("5"),
                            //     ),
                            //     DropdownMenuItem(
                            //       value: 12,
                            //       child: Text("6"),
                            //     ),
                            //   ],
                            //   onChanged: (value) {
                            //     controller.endTimeController.text =
                            //         value.toString();
                            //   },
                            // )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const TitleText(
                    title: 'Description',
                    // fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: controller.descriptionController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) =>
                        CustomValidation.descriptionValidation(
                            value: value!, fieldName: "description"),
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
                        hintText: "Description"),
                    maxLines: 10,
                    minLines: 2,
                    maxLength: 200,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(
                                MediaQuery.of(context).size.width * 0.75, 55)),
                        onPressed: () {
                          if (controller.formKey.currentState!.validate()) {
                            if (controller.selectedCategoryIndex.value >
                                controller.categoryList.length) {
                              // Get.showSnackbar(snackbar)
                              Get.snackbar("Error", "Select Category",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Theme.of(context).cardColor);
                            } else {
                              TaskModel task = TaskModel(
                                uuid: const Uuid().v4(),
                                taskName: controller.taskNameController.text,
                                description:
                                    controller.descriptionController.text,
                                dueDate: DateTime.parse(
                                    controller.dateController.text),
                                startTime: controller.startTimeController.text,
                                endTime: controller.endTimeController.text,
                                isCompleted: false,
                                isPending: true,
                                isMissed: false,
                                category: controller.categoryList[
                                    controller.selectedCategoryIndex.value],
                              );

                              controller.addUser(task: task);
                            }
                          }
                        },
                        child: const Text("Create Task")),
                  ),
                  const SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
