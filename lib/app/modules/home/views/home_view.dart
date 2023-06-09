import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticmind/app/modules/calender/views/calender_view.dart';
import 'package:ticmind/app/modules/history/views/history_view.dart';
import 'package:ticmind/app/modules/main/views/main_view.dart';
import 'package:ticmind/app/modules/profile/views/profile_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
// appBar: Obx(() => ),
      body: Obx(() => [
            const MainView(),
            const CalenderView(),
            const SizedBox(),
            const HistoryView(),
            const ProfileView()
          ][controller.navigationIndex.value]),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        //Floating action button on Scaffold
        onPressed: () {
          //code to execute on button press
          Get.toNamed('./create-task');
        },
        child: const Icon(
          Icons.add,
          size: 35,
        ), //icon inside button
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      bottomNavigationBar: GetBuilder(
        init: controller,
        initState: (_) {},
        builder: (_) {
          return NavigationBar(
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            onDestinationSelected: (int index) {
              controller.updateNavigationIndex(index);
            },
            selectedIndex: controller.navigationIndex.value,
            animationDuration: const Duration(milliseconds: 500),
            // labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            destinations: const [
              NavigationDestination(
                selectedIcon: Icon(Icons.home, size: 30),
                icon: Icon(Icons.home_outlined, size: 30),
                label: 'Home',
              ),
              NavigationDestination(
                selectedIcon: Icon(
                  Icons.calendar_month,
                  size: 30,
                ),
                icon: Icon(
                  Icons.calendar_month_outlined,
                  size: 30,
                ),
                label: 'Calender',
              ),

              // NavigationDestination(
              //   selectedIcon: Text(""),
              //   icon: Text(""),
              //   label: '',
              // ),
              SizedBox(),
              NavigationDestination(
                selectedIcon: Icon(Icons.history, size: 30),
                icon: Icon(Icons.history_outlined, size: 30),
                label: 'History',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.person, size: 30),
                icon: Icon(Icons.person_outlined, size: 30),
                label: 'Profile',
              ),
            ],
          );
        },
      ),
    );
  }
}
