import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticmind/app/core/custom_validation.dart';
import 'package:ticmind/app/modules/authentication/views/forgot_password.dart';
import 'package:ticmind/app/modules/authentication/views/signup_view.dart';

import '../controllers/authentication_controller.dart';

class LoginView extends GetView<AuthenticationController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Login'),
      //   centerTitle: true,
      // ),
      body: SafeArea(
        child: Form(
          key: controller.loginFormKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
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
                  padding: EdgeInsets.only(left: 20, bottom: 30, top: 50),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      // color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: TextFormField(
                    controller: controller.emailController,
                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => CustomValidation.validateEmail(
                      email: value!,
                    ),
                    keyboardType: TextInputType.emailAddress,
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
                        labelText: 'Email'),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // const SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Obx(() => TextFormField(
                        controller: controller.passwordController,
                        // autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => CustomValidation.validatePassword(
                          password: value!,
                        ),
                        maxLength: 25,
                        obscureText: controller.isLoginPasswordHide.value,
                        decoration: InputDecoration(
                            fillColor:
                                Theme.of(context).scaffoldBackgroundColor,
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
                                controller.isLoginPasswordHide.value =
                                    !controller.isLoginPasswordHide.value;
                              },
                              icon: Icon(
                                controller.isLoginPasswordHide.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                            labelText: 'Password'),
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Get.to(() => const ForgotPasswordPage()),
                    child: const Padding(
                      padding: EdgeInsets.only(right: 18),
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(
                              MediaQuery.of(context).size.width * 0.75, 55)),
                      onPressed: () {
                        if (controller.loginFormKey.currentState!.validate()) {
                          controller.signInUsingEmailPassword();
                        }
                      },
                      child: const Text("Login",  style: TextStyle(fontSize: 20),
                      )),
                ),
                // const SizedBox(
                //   height: 10,
                // ),
                // Align(
                //   alignment: Alignment.center,
                //   child: ElevatedButton(
                //       style: ElevatedButton.styleFrom(
                //           fixedSize: Size(
                //               MediaQuery.of(context).size.width * 0.75, 55)),
                //       onPressed: () {
                //         controller.googleSignIn();
                //       },
                //       child: const Text("Sign With Google")),
                // ),
                const SizedBox(
                  height: 30,
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 25,
                    ),
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                            // color: HexColor("#001225"),
                            fontSize: 14.0),
                        children: <TextSpan>[
                          const TextSpan(
                            text: 'Dont have an account? ',
                          ),
                          TextSpan(
                            text: 'Sign up',
                            style: const TextStyle(
                              // color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.to(() => const RegisterView());
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
