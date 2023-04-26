import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticmind/app/modules/authentication/views/login_view.dart';
import 'package:ticmind/app/modules/home/views/home_view.dart';

import '../controllers/authentication_controller.dart';

class AuthenticationView extends GetView<AuthenticationController> {
  const AuthenticationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: controller,
        initState: (_) {},
        builder: (_) {
          return controller.user == null ? const LoginView() : const HomeView();
        },
      ),
    );
  }
}
