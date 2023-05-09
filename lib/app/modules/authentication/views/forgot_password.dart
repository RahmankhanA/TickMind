import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticmind/app/core/custom_validation.dart';
import 'package:ticmind/app/modules/authentication/controllers/authentication_controller.dart';

class ForgotPasswordPage extends GetView<AuthenticationController> {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
        centerTitle: true,
      ),
      body: Form(
          key: controller.forgotPasswordFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                padding: EdgeInsets.only(left: 20, bottom: 30, top: 50),
                child: Text(
                  "Resset Password",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    // color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: TextFormField(
                  controller: controller.emailController,
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
              )
,
              const SizedBox(
                height: 70,
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(
                            MediaQuery.of(context).size.width * 0.75, 55)),
                    onPressed: () {
                      if (controller.loginFormKey.currentState!.validate()) {
                        controller.ressetPassword();
                      }
                    },
                    child: const Text("Resset Password", style: TextStyle(
                      fontSize: 20
                    ),)),
              ),
            ],
          )),
    );
  }
}
