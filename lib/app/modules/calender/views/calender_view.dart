import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';


import '../controllers/calender_controller.dart';

class CalenderView extends GetView<CalenderController> {
  const CalenderView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.getTaskListOfSelectedDay(day: DateTime.now());
    return Scaffold(
        appBar: AppBar(
          title: const Text('Calender'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GetBuilder(
                init: controller,
                initState: (_) {},
                builder: (_) {
                  return TableCalendar(
                    firstDay: DateTime(1900),
                    focusedDay: controller.selectedDay,
                    // focusedDay: DateTime.now(),
                    lastDay: DateTime(3900),
                    currentDay: DateTime.now(),

                    // calendarController: _calendarController,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    calendarFormat: CalendarFormat.month,
                    formatAnimationCurve: Curves.bounceInOut,
                    // weekNumbersVisible: true,
                    holidayPredicate: (day) {
                      day = DateTime.parse(day.toString().split(' ').first);
                      if (controller.taskDayList.contains(day)) {
                        return true;
                      }
                      return false;
                    },
                    selectedDayPredicate: (day) {
                      if (day == controller.selectedDay) {
                        return true;
                      }
                      return false;
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      controller.selectedDay = selectedDay;
                      controller.getTaskListOfSelectedDay(day: selectedDay);
                    },

                    calendarStyle: const CalendarStyle(
                      // weekNumberTextStyle: TextStyle(fontSize: 12, color: Colors.white),
                      weekendTextStyle: TextStyle(
                        fontSize: 12,
                        // color: Color(0xFFBFBFBF),
                      ),
                      todayDecoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      // markersMaxCount: 1,
                      // markersPositionBottom: -15,

                      markersAlignment: Alignment.bottomCenter,
                      markersOffset: PositionedOffset(),
                      markerDecoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.redAccent,
                      ),
                    ),
                    headerStyle: const HeaderStyle(
                      titleCentered: true,
                      formatButtonVisible: false,
                      formatButtonDecoration: BoxDecoration(
                        color: Colors.orange,
                        //   borderRadius: BorderRadius.circular(20.0),
                      ),
                      formatButtonTextStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    calendarBuilders: CalendarBuilders(
                      // todayBuilder: (context, day, focusedDay) {
                      //   return Column(
                      //     children: [
                      //       Text(focusedDay.day.toString(),
                      //           style: const TextStyle(fontSize: 18)),
                      //       const Icon(
                      //         Icons.star,
                      //         color: Colors.amberAccent,
                      //       ),
                      //     ],
                      //   );
                      // },

                      // selectedBuilder: (context, day, focusedDay) {
                      //   log("selected day builder ${day.day}");
                      //   return GetBuilder(
                      //     init: controller,
                      //     builder: (controller) {
                      //       return Container(
                      //         child: Text(
                      //           day.day.toString(),
                      //         ),
                      //       );
                      //     },
                      //   );
                      // },
                      holidayBuilder: (context, day, focusedDay) {
                        // log(day.isBefore(focusedDay).toString());
                        // log(day.toString().split(' ')[0].replaceAll('-', '/'));
                        return Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Theme.of(context).iconTheme.color!,
                              )),
                          child: Center(
                            child: Text(
                              day.day.toString(),
                              style: const TextStyle(
                                // color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        );

                        // return Column(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   children: [
                        //     Text(day.day.toString(),
                        //         style: const TextStyle(fontSize: 15)),
                        //     Row(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       crossAxisAlignment: CrossAxisAlignment.center,
                        //       children: const [
                        //         Icon(
                        //           Icons.star,
                        //           color: Colors.amberAccent,
                        //           size: 8.0,
                        //         ),
                        //         Icon(
                        //           Icons.star,
                        //           color: Colors.amberAccent,
                        //           size: 8.0,
                        //         ),
                        //         Icon(
                        //           Icons.star,
                        //           color: Colors.amberAccent,
                        //           size: 8.0,
                        //         ),
                        //       ],
                        //     ),
                        //   ],
                        // );
                      },
                    ),
                  );
                },
              ),
              // CustomCalendar(selectedDate: DateTime.now(),),
              const SizedBox(height: 16.0),
              Expanded(
                child: GetBuilder(
                  init: controller,
                  initState: (_) {},
                  builder: (_) {
                    return ListView.builder(
                      itemCount: controller.selectedDayTaskList.length,
                      itemBuilder: (context, index) {
                        final task = controller.selectedDayTaskList[index];
                        return Card(
                          child: ListTile(
                            onTap: () {
                              // Get.to(() => CategoryDetailsPage(
                              //     category: task.keys.first,
                              //     taskList: task.values.first));

Get.toNamed('./category-details', arguments: {
                                'category':
                                    task.keys.first,
                                'taskList':
                                   task.values.first
                              });
                            },
                            title: Text(task.keys.first),
                            subtitle: Text(
                              "${task.values.first.first.startTime} - ${task.values.first.first.endTime}",
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
