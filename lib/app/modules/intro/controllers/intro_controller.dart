import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ticmind/app/data/constant/assets_constant.dart';
import 'package:ticmind/app/modules/intro/models/intro_content_model.dart';

class IntroController extends GetxController {
  RxInt currentIndex = 0.obs;
  PageController pagecontroller = PageController();

  // actionbutton() {
  //   if (currentIndex.value == contents.length - 1) {
  //     preferences!.setBool(UIConstant.DISPLAYINTRO, true);
  //     Get.off(() => Demopagestate());
  //   }
  //   pagecontroller.nextPage(duration: 800.milliseconds, curve: Curves.ease);
  // }

  //  final List<Introduction> list = [

  //   Introduction(

  //      title: "Create Your Task",
  //       subTitle:
  //           "Create your task to make sure every task you have can completed on time",
  //     imageUrl: AssetsConstant.introFirstImage,
  //   ),
  //   Introduction(
  //     title: "Manage your Daily Task",
  //       subTitle:
  //           "By using this application you will be able to manage your daily tasks",
  //     imageUrl: AssetsConstant.introSecondtImage,
  //   ),
  //   Introduction(
  //       title: "Checklist Finished Task",
  //       subTitle:
  //           "If you completed your task, so you can view the result you work for each day",
  //     imageUrl: AssetsConstant.introThirdImage,
  //   ),
  // ];

  List<IntroContent> contents = [
    IntroContent(
        imageName: AssetsConstant.introFirstImage,
        title: "Create Your Task",
        description:
            "Create your task to make sure every task you have can completed on time"),
    IntroContent(
        imageName: AssetsConstant.introSecondtImage,
        title: "Manage your Daily Task",
        description:
            "By using this application you will be able to manage your daily tasks"),
    IntroContent(
        imageName: AssetsConstant.introThirdImage,
        title: "Checklist Finished Task",
        description:
            "If you completed your task, so you can view the result you work for each day")
  ];
}
