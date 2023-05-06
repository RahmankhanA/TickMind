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
                        hintText: "Enter Task Name"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TitleText(title: 'Category'),
                      AddCategory(
                        controller: controller,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 50,
                    child: GetBuilder(
                      init: controller,
                      initState: (_) {},
                      builder: (_) {
                        return Visibility(
                          replacement: const Center(
                            child: Text(
                              "Add Category First",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          visible: controller.categoryList.isNotEmpty,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.categoryList.length,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(width: 10);
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return Obx(() => Card(
                                    // color: Theme.of(context).primaryColor,
                                    color: controller
                                                .selectedCategoryIndex.value ==
                                            index
                                        ? Theme.of(context).primaryColor
                                        : Theme.of(context).cardColor,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 8.0),
                                      child: Center(
                                          child: GestureDetector(
                                        onTap: () => controller
                                            .selectedCategoryIndex
                                            .value = index,
                                        // onDoubleTap: () {
                                        //   log("double tap");
                                        // controller.deleteCategory(
                                        //     index: index,
                                        //     category: controller
                                        //         .categoryList[index]);
                                        // },
                                        onLongPress: () {
                                          log("on long press");
                                          showMenu(
                                              context: context,
                                              shape: BeveledRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                side: BorderSide(
                                                    width: 0.2,
                                                    color: Theme.of(context)
                                                        .iconTheme
                                                        .color!),
                                              ),
                                              position: RelativeRect.fromLTRB(
                                                  Get.width * 0.4,
                                                  Get.height * 0.4,
                                                  Get.width * 0.4,
                                                  Get.height * 0.4),
                                              items: [
                                                const PopupMenuItem(
                                                  child: Text("Edit"),
                                                ),
                                                PopupMenuItem(
                                                  child: const Text("Delete"),
                                                  onTap: () =>
                                                      controller.deleteCategory(
                                                          index: index,
                                                          category: controller
                                                                  .categoryList[
                                                              index]),
                                                ),
                                                const PopupMenuItem(
                                                  child: Text("Info"),
                                                ),
                                              ]);
                                        },
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
                        );
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
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(), //get today's date
                          firstDate: DateTime.now(), //DateTime.now() - not to allow to choose before today.
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
                                  hintText: "Start Time"),
                              onTap: () async {
                                TimeOfDay? pickedTime = await showTimePicker(
                                  helpText: "Select Start Time",
                                  initialTime: TimeOfDay.now(),
                                  context: context, //context of current state
                                );

                                if (pickedTime != null) {
                                  // ignore: use_build_context_synchronously
                                  controller.startTimeController.text =
                                      pickedTime.format(Get.context!);
                                } else {
                                  print("Time is not selected");
                                }
                              },
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
                                  hintText: "End Time"),
                              onTap: () async {
                                TimeOfDay? pickedTime = await showTimePicker(
                                  helpText: "Select End Time",
                                  initialTime: TimeOfDay.now(),
                                  context: context, //context of current state
                                );

                                if (pickedTime != null) {
                                  controller.endTimeController.text =
                                      pickedTime.format(Get.context!);
                                } else {
                                  log("Time is not selected");
                                }
                              },
                            ),
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

                              controller.addTask(task: task);
                            }
                          }
                        },
                        child: const Text(
                          "Create Task",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        )),
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

class AddCategory extends StatelessWidget {
  const AddCategory({
    super.key,
    required this.controller,
  });

  final CreateTaskController controller;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: () {
          String inputText = '';
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: const Text("Add Category"),
                content: Form(
                  key: controller.addCategoryFormKey,
                  child: TextFormField(
                    autofocus: true,
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
                        hintText: "Enter Category"),
                    onChanged: (value) {
                      inputText = value;
                    },
                    validator: (value) {
                      if (inputText == '' || inputText.isEmpty) {
                        return 'category name required';
                      }
                      return null;
                    },
                    onFieldSubmitted: (value) {
                      if (controller.addCategoryFormKey.currentState!
                          .validate()) {
                        controller.addCategory(
                            category: inputText.capitalizeFirst.toString());
                        Get.back();
                      }
                    },
                  ),
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            minimumSize: Size(Get.width * 0.3, 40)),
                        onPressed: () => Get.back(),
                        child: const Text("Cancel"),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                          style: OutlinedButton.styleFrom(
                              minimumSize: Size(Get.width * 0.3, 40)),
                          onPressed: () {
                            if (controller.addCategoryFormKey.currentState!
                                .validate()) {
                              controller.addCategory(
                                  category:
                                      inputText.capitalizeFirst.toString());
                              Get.back();
                            }
                          },
                          child: const Text("Add")),
                    ],
                  )
                ],
              );
            },
          );
        },
        child: const Text("Add Category"));
  }
}
