import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  User? user;
  @override
  void onInit() {
    super.onInit();
    //Listen to Auth State changes

    firebaseAuth.authStateChanges().listen((event) => updateUserState(event));
  }

  updateUserState(event) {
    user = event;
    // user?.updateDisplayName("Abdul Rahaman");
    update();
  }

  Future<void> updateUserProfile({required String name}) async {
    String errorMessage = '';
    EasyLoading.show(
      status: 'Updating Profile',
      maskType: EasyLoadingMaskType.black,
    );
    // if (email != firebaseAuth.currentUser!.email) {
    //   try {
    //   await  firebaseAuth.currentUser?.updateEmail(email);
    //   } on FirebaseAuthException catch (error) {
    //     log(error.message!);
    //     errorMessage = error.message.toString();
    //   } catch (error) {
    //     errorMessage = "Something went wrong";
    //   }
    // }
    if (name != firebaseAuth.currentUser?.displayName) {
      try {
        await firebaseAuth.currentUser?.updateDisplayName(name);
      } on FirebaseAuthException catch (error) {
        log(error.message!);
        errorMessage = error.message.toString();
      } catch (error) {
        errorMessage = "Something went wrong";
      }
    }
    EasyLoading.dismiss();
    // log('error message: $errorMessage');
    if (errorMessage == '') {
      Get.snackbar(
        "Profile Update",
        "Your profile successfuly updated",
        snackPosition: SnackPosition.BOTTOM,
      );
      log("Showing success");
      // Get.offAllNamed('./home');
      // Get.back();
      user=firebaseAuth.currentUser;
      update();
      return;
    } else {
      log("Showing error");
      Get.snackbar(
        "Profile Update",
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
      );
    }
    // log(errorMessage);
    return;
  }

  void logoutUser() async {
    EasyLoading.show(
      status: 'Updating Profile',
      maskType: EasyLoadingMaskType.black,
    );
    
    await firebaseAuth.signOut();
    EasyLoading.dismiss();
    Get.snackbar(
      "Logout",
      "You have successfuly logged out",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent,
    );
    Get.toNamed('./authentication');
  }

  void verifyEmail() {
    // firebaseAuth.currentUser!.sendEmailVerification(ActionCodeSettings(url: url));
  }

  void changePassword(
      {required String currentPassword, required String newPassword}) async {
    String errorMessage = '';
    EasyLoading.show(
      status: 'Updating Password',
      maskType: EasyLoadingMaskType.black,
    );
    final cred = EmailAuthProvider.credential(
        email: user!.email.toString(), password: currentPassword);
    try {
      var data = await user?.reauthenticateWithCredential(cred);
      log(data.toString());
      user?.updatePassword(newPassword);
    } on FirebaseAuthException catch (err) {
      errorMessage = err.message.toString();
    } catch (error) {
      errorMessage = 'Something went wrong';
    }

    log(errorMessage);
    if (errorMessage == '') {
      Get.snackbar(
        "Update Password",
        "You have successfuly updated password ",
        snackPosition: SnackPosition.BOTTOM,
      );
    }else{
       Get.snackbar(
        "Update Password",
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
      );
    }

    EasyLoading.dismiss();
    //  Get.offAllNamed('./home');
  }
}
