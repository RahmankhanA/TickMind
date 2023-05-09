// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticmind/app/core/custom_validation.dart';
import 'package:ticmind/app/modules/profile/controllers/profile_controller.dart';

class EditProfilePage extends StatefulWidget {
  final User user;
  const EditProfilePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final editProfileFormKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  late ProfileController profileController;

  @override
  void initState() {
    super.initState();
    profileController = Get.find<ProfileController>();
    usernameController.text = widget.user.displayName.toString();
    emailController.text = widget.user.email.toString();
  }

  @override
  void dispose() {
    if (FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus();
    }
    usernameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          if (FocusScope.of(context).hasFocus) {
            FocusScope.of(context).unfocus();
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
              key: editProfileFormKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: usernameController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => CustomValidation.validateName(
                        name: usernameController.text),
                    decoration: InputDecoration(
                        fillColor: Theme.of(context).scaffoldBackgroundColor,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).iconTheme.color!),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelText: "Username"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: emailController,
                    readOnly: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => CustomValidation.validateEmail(
                        email: emailController.text),
                    decoration: InputDecoration(
                        fillColor: Theme.of(context).scaffoldBackgroundColor,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).iconTheme.color!),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelText: "Email"),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     const Text(
                  //       "Is Email Verified",
                  //       style: TextStyle(fontSize: 20),
                  //     ),
                  //     GetBuilder(
                  //       init: profileController,
                  //       initState: (_) {},
                  //       builder: (_) {
                  //         return Switch(
                  //             value: profileController.user!.emailVerified,
                  //             onChanged: (val) {
                  //               if(!profileController.user!.emailVerified){

                  //               profileController.verifyEmail();
                  //               }
                  //             });
                  //       },
                  //     )
                  //   ],
                  // ),
                  // const SizedBox(
                  //   height: 50,
                  // ),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(
                              MediaQuery.of(context).size.width * 0.75, 55)),
                      onPressed: () {
                        if (FocusScope.of(context).hasFocus) {
                          FocusScope.of(context).unfocus();
                        }
                        if (editProfileFormKey.currentState!.validate()) {
                          profileController.updateUserProfile(
                            name: usernameController.text,
                          );
                        }
                      },
                      child: const Text(
                        "Save",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
