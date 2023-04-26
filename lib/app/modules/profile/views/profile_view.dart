import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              /// -- IMAGE
              ///
              const SizedBox(
                height: 20,
              ),
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: const Image(
                            image: AssetImage('assets/images/Boy Study.png'))),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        // color: Colors.blue
                      ),
                      child: const Icon(Icons.edit),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Text("ProfileHeading",
              //     style: Theme.of(context).textTheme.headlineMedium),
              Text("${controller.user?.displayName?.toUpperCase()}",
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 20),

              const Divider(),
              const SizedBox(height: 10),
              const ListTile(
                title: Text("Edit Profile"),
                leading: Icon(
                  Icons.edit,
                  // color: Colors.red,
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              const ListTile(
                title: Text("Change Password"),
                leading: Icon(
                  Icons.lock,
                  // color: Colors.red,
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              const ListTile(
                title: Text("Share App With Friends"),
                leading: Icon(
                  Icons.share,
                  color: Colors.blue,
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              const ListTile(
                title: Text("Rate This App"),
                leading: Icon(
                  Icons.reviews_rounded,
                  color: Colors.blue,
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              const ListTile(
                title: Text("Our Other Apps"),
                leading: Icon(
                  Icons.apps,
                  color: Colors.blue,
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              const ListTile(
                title: Text("Setting"),
                leading: Icon(
                  Icons.settings,
                  // color: Colors.red,
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              const ListTile(
                title: Text("Logout"),
                leading: Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              // ProfileMenuWidget(
              //     title: "Information",
              //     icon: LineAwesomeIcons.info,
              //     onPress: () {}),
              // ProfileMenuWidget(
              //     title: "Logout",
              //     icon: LineAwesomeIcons.alternate_sign_out,
              //     textColor: Colors.red,
              //     endIcon: false,
              //     onPress: () {
              //       Get.defaultDialog(
              //         title: "LOGOUT",
              //         titleStyle: const TextStyle(fontSize: 20),
              //         content: const Padding(
              //           padding: EdgeInsets.symmetric(vertical: 15.0),
              //           child: Text("Are you sure, you want to Logout?"),
              //         ),
              //         confirm: Expanded(
              //           child: ElevatedButton(
              //             onPressed: () {},
              //             //     AuthenticationRepository.instance.logout(),
              //             style: ElevatedButton.styleFrom(
              //                 backgroundColor: Colors.redAccent,
              //                 side: BorderSide.none),
              //             child: const Text("Yes"),
              //           ),
              //         ),
              //         cancel: OutlinedButton(
              //             onPressed: () => Get.back(), child: const Text("No")),
              //       );
              //     }),
            ],
          ),
        ),
      ),
    );
  }
}
