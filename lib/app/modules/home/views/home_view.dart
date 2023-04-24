import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const Text(
              'HomeView is working',
              style: TextStyle(fontSize: 20),
            ),
            TextButton(onPressed: () {}, child: const Text("Text Button")),
            ElevatedButton(
                onPressed: () {}, child: const Text("Elevated Button")),
            OutlinedButton(
                onPressed: () {}, child: const Text("Outlined Button")),
            IconButton(onPressed: () {}, icon: const Text("Outlined Button")),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        //Floating action button on Scaffold
        onPressed: () {
          //code to execute on button press
        },
        child: const Icon(
          Icons.add,
          size: 35,
        ), //icon inside button
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: GetBuilder(
        init: controller,
        initState: (_) {},
        builder: (_) {
          return NavigationBar(
            elevation: 0,
            backgroundColor: Colors.white,
            onDestinationSelected: (int index) {
              controller.updateNavigationIndex(index);
            },
            selectedIndex: controller.navigationIndex,
            animationDuration: const Duration(milliseconds: 500),
            // labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            destinations: const [
              NavigationDestination(
                selectedIcon: Icon(Icons.home,size: 30),
                icon: Icon(Icons.home_outlined,size: 30),
                label: 'Home',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.calendar_month,size: 30,),
                icon: Icon(Icons.calendar_month_outlined,size: 30,),
                label: 'Calender',
              ),

              // NavigationDestination(
              //   selectedIcon: Text(""),
              //   icon: Text(""),
              //   label: '',
              // ),
              SizedBox(),
              NavigationDestination(
                selectedIcon: Icon(Icons.history,size: 30),
                icon: Icon(Icons.history_outlined,size: 30),
                label: 'History',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.person,size: 30),
                icon: Icon(Icons.person_outlined,size: 30),
                label: 'Profile',
              ),
            ],
          );
        },
      ),
    );
  }
}
