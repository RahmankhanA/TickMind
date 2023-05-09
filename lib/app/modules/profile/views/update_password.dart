import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticmind/app/modules/profile/controllers/profile_controller.dart';

class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({super.key});

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  bool isCurrentPasswordhidden = true;
  bool isNewPasswordhidden = true;
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  late ProfileController profileController;
  @override
  void initState() {
    profileController=Get.find<ProfileController>();
    super.initState();
  }

  @override
  void dispose() {
    // Hiding keyboard
    FocusScope.of(context).unfocus();
    // disposing TextEditingControllers

    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Password"),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 5.2,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Theme.of(context).primaryColorDark,
                            Theme.of(context).primaryColorDark,
                          ],
                        ),
                        borderRadius: const BorderRadius.only(
                          //topLeft: Radius.circular(100),
                          //topRight: Radius.circular(150),
                          bottomRight: Radius.circular(100),
                          bottomLeft: Radius.circular(100),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          "assets/images/logo-tickmind-removebg.png",
                          color: Colors.white,
                          fit: BoxFit.fill,
                          // width: MediaQuery.of(context).size.width*1.5,
                          // height: MediaQuery.of(context).size.height*1.5 ,
                          scale: 1.0,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 30, top: 30),
                    child: Text(
                      "Update Password",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        // color: Colors.white,
                      ),
                    ),
                  ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: TextFormField(
                      controller: currentPasswordController,
                      obscureText: isCurrentPasswordhidden,
                      validator: (value) {
                        if (currentPasswordController.text.isEmpty) {
                          return 'current password required';
                        }
                        return null;
                      },
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
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(
                                () {
                                  isCurrentPasswordhidden =
                                      !isCurrentPasswordhidden;
                                },
                              );
                            },
                            icon: Icon(isCurrentPasswordhidden
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                          labelText: 'Current Password'),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: TextFormField(
                      controller: newPasswordController,
                      obscureText: isNewPasswordhidden,
                       validator: (value) {
                        if (newPasswordController.text.isEmpty) {
                          return 'new password required';
                        }
                        return null;
                       },
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
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(
                                () {
                                  isNewPasswordhidden = !isNewPasswordhidden;
                                },
                              );
                            },
                            icon: Icon(isNewPasswordhidden
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                          labelText: 'New Password'),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: TextFormField(
                      controller: confirmPasswordController,
                      obscureText: isNewPasswordhidden,
                       validator: (value) {
                        if (confirmPasswordController.text.isEmpty) {
                          return 'confirm password required';
                        }else if(confirmPasswordController.text!=newPasswordController.text){
                          return 'Password not match';
                        }
                        return null;
                       },
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
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(
                                () {
                                  isNewPasswordhidden = !isNewPasswordhidden;
                                },
                              );
                            },
                            icon: Icon(isNewPasswordhidden
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                          labelText: 'Confirm Password'),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
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
                        if (formKey.currentState!.validate()) {
                          profileController.changePassword(currentPassword: currentPasswordController.text
                          , newPassword: newPasswordController.text);
                        }
                      },
                      child: const Text(
                        "Update Password",
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
