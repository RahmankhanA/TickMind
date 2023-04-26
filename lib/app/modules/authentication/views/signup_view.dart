import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticmind/app/core/custom_validation.dart';
import 'package:ticmind/app/modules/authentication/controllers/authentication_controller.dart';

class RegisterView extends GetView<AuthenticationController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('AuthenticationView'),
      //   centerTitle: true,
      // ),
      body: SafeArea(
        child: Form(
          key: controller.signupFormKey,
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
                    "Register",
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
                    controller: controller.nameController,
                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => CustomValidation.validateName(
                      name: value!,
                    ),
                    maxLength: 25,
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
                        labelText: 'Username'),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: TextFormField(
                    controller: controller.emailController,
                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => CustomValidation.validateEmail(
                      email: value!,
                    ),
                    // maxLength: 25,.
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
                  alignment: Alignment.center,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(
                              MediaQuery.of(context).size.width * 0.75, 55)),
                      onPressed: () {
                        if (controller.signupFormKey.currentState!.validate()) {
                          controller.registerUsingEmailPassword();
                        }
                      },
                      child: const Text("Signup")),
                ),
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
                            text: 'Already have an account? ',
                          ),
                          TextSpan(
                            text: 'LogIn',
                            style: const TextStyle(
                              // color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.back();
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
