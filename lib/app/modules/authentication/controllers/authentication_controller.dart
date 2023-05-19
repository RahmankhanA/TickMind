import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class AuthenticationController extends GetxController {
  User? user;
  final loginFormKey = GlobalKey<FormState>();
  final forgotPasswordFormKey = GlobalKey<FormState>();
  final signupFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // TextEditingController emailController = TextEditingController(
  //     text: kDebugMode ? 'abdulrahman13081999@gmail.com' : '');
  // TextEditingController passwordController =
  //     TextEditingController(text: kDebugMode ? 'King=Kong5656' : '');
  TextEditingController confirmPasswordController = TextEditingController();
  RxBool isLoginPasswordHide = true.obs;

// SignIn _googleSignIn = GoogleSignIn();  final Google
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    //Listen to Auth State changes
    FirebaseAuth.instance
        .authStateChanges()
        .listen((event) => updateUserState(event));
  }

  updateUserState(event) {
    user = event;
    update();
  }

  // Future googleSignIn() async {
  //   final googleUser = await _googleSignIn.signIn();
  //   final googleAuth = await googleUser!.authentication;
  //   final AuthCredential credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth.accessToken,
  //     idToken: googleAuth.idToken,
  //   );
  //   print(credential);
  //   final user = await _auth.signInWithCredential(credential);
  //   print(user);
  //   Get.toNamed('/home');
  //   return user;
  // }

  Future<User?> signInUsingEmailPassword() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String errorMessage = '';
    EasyLoading.show(
      status: 'logging',
      maskType: EasyLoadingMaskType.black,
    );
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided.');
        errorMessage = 'Wrong password provided.';
      } else {
        errorMessage = e.message.toString();
        log(e.toString());
      }
    }
    EasyLoading.dismiss();
    if (user != null) {
      Get.snackbar(
        "Authentication",
        "You have successfuly logged In",
        // snackPosition: SnackPosition.BOTTOM,
      );
      Get.offAllNamed('/home');
    } else {
      Get.snackbar("Authentication", errorMessage,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent);
    }
    return user;
  }

  Future<User?> registerUsingEmailPassword() async {
    String errorMessage = '';
    EasyLoading.show(
      status: 'Creating Account',
      maskType: EasyLoadingMaskType.black,
    );
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      user = userCredential.user;
      await user?.updateDisplayName(nameController.text);
      await user?.reload();
      user = _auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
        errorMessage = 'The account already exists for that email.';
      }
    } catch (e) {
      log(e.toString());
      errorMessage = 'Something went wrong';
    }
    EasyLoading.dismiss();
    if (user != null) {
      Get.snackbar(
        "Authentication",
        "You have successfuly logged In",
        // snackPosition: SnackPosition.BOTTOM,
      );
      signInUsingEmailPassword();
    } else {
      Get.snackbar("Authentication", errorMessage,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent);
    }

    return user;
  }

  void ressetPassword() async {
    String errorMessage = '';
    EasyLoading.show(
      status: 'loading ...',
      maskType: EasyLoadingMaskType.black,
    );
    try {
      await _auth.sendPasswordResetEmail(email: emailController.text);
    } on FirebaseAuthException catch (error) {
      errorMessage = error.message.toString();
    } catch (error) {
      errorMessage = 'Something went wrong';
    }

    EasyLoading.dismiss();
    if (errorMessage == '') {
      Get.snackbar(
        "Password Resset",
        'An email sent to your mail for resseting password',
        snackPosition: SnackPosition.BOTTOM,
        // backgroundColor: Colors.redAccent,
      );
      // Get.toNamed('./authentication');
    } else {
      Get.snackbar(
        "Password Resset",
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
      );
    }
  }
}
