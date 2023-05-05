import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationController extends GetxController {
  User? user;
  final loginFormKey = GlobalKey<FormState>();
  final signupFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController(text: kDebugMode?'abdulrahman13081999@gmail.com':'');
  TextEditingController passwordController = TextEditingController(text:kDebugMode? 'King=Kong5657':'');
  TextEditingController confirmPasswordController = TextEditingController();
  RxBool isLoginPasswordHide = true.obs;

  final GoogleSignIn _googleSignIn = GoogleSignIn();
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

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided.');
      }
      else{
        log(e.toString());
      }
    }
    print(user);
    Get.offAllNamed('/home');
    return user;
  }

  Future<User?> registerUsingEmailPassword() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      user = userCredential.user;
      await user?.updateDisplayName(nameController.text);
      await user?.reload();
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    print(user);
    return user;
  }
}
