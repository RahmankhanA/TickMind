import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:ticmind/app/modules/main/views/category_details.dart';

import '../controllers/calender_controller.dart';

class CalenderView extends GetView<CalenderController> {
  const CalenderView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.getTaskListOfSelectedDay(day: DateTime.now());
    return Scaffold(
        appBar: AppBar(
          title: const Text('CalenderView'),
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
                    focusedDay: DateTime.now(),
                    lastDay: DateTime(3900),

                    // calendarController: _calendarController,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    calendarFormat: CalendarFormat.month,
                    holidayPredicate: (day) {
                      if (day.day % 3 == 0) {
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
                      weekendTextStyle:
                          TextStyle(fontSize: 12, color: Color(0xFFBFBFBF)),
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
                      // formatButtonDecoration: BoxDecoration(
                      //   color: Colors.orange,
                      //   borderRadius: BorderRadius.circular(20.0),
                      // ),
                      formatButtonTextStyle: TextStyle(color: Colors.white),
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
                      holidayBuilder: (context, day, focusedDay) {
                        // log(day.isBefore(focusedDay).toString());
                        // log(day.toString().split(' ')[0].replaceAll('-', '/'));
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(day.day.toString(),
                                style: const TextStyle(fontSize: 15)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.star,
                                  color: Colors.amberAccent,
                                  size: 8.0,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.amberAccent,
                                  size: 8.0,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.amberAccent,
                                  size: 8.0,
                                ),
                              ],
                            ),
                          ],
                        );
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
                              Get.to(() => CategoryDetailsPage(
                                  category: task.keys.first,
                                  taskList: task.values.first));
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
