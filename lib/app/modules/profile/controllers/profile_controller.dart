import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  User? user;
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
}
