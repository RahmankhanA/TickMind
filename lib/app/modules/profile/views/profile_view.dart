import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

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
              ListTile(
                onTap: () {
                  Share.share(
                      'check out my website https://play.google.com/store/apps/details?id=com.rahman.ticmind',
                      subject: 'Look what I made!');
                },
                title: const Text("Share App With Friends"),
                leading: const Icon(
                  Icons.share,
                  color: Colors.blue,
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                onTap: () async {
                  Uri url = Uri.parse(
                      'https://play.google.com/store/apps/details?id=com.rahman.ticmind');
                  if (await canLaunchUrl(url)) {
                    launchUrl(url,
                        mode: LaunchMode.externalNonBrowserApplication);
                  }
                },
                title: const Text("Rate This App"),
                leading: const Icon(
                  Icons.reviews_rounded,
                  color: Colors.blue,
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                onTap: () async {
                  log("our other apps");
                  Uri url = Uri.parse(
                      'https://play.google.com/store/apps/dev?id=7983241434233494489');
                  if (await canLaunchUrl(url)) {
                    launchUrl(url,
                        mode: LaunchMode.externalNonBrowserApplication);
                  }
                },
                title: const Text("Our Other Apps"),
                leading: const Icon(
                  Icons.apps,
                  color: Colors.blue,
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                onTap: () async {
                  Uri url = Uri.parse('https://google.com');
                  if (await canLaunchUrl(url)) {
                    launchUrl(
                      url,
                    );
                  }
                },
                title: const Text("Setting"),
                leading: const Icon(
                  Icons.settings,
                  
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              const ListTile(
                title: Text("Logout"),
                leading: Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
