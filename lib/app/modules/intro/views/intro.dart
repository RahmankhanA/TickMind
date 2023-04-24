import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:ticmind/app/data/constant/assets_constant.dart';

class IntroScreenCustomConfig extends StatefulWidget {
  const IntroScreenCustomConfig({Key? key}) : super(key: key);

  @override
  IntroScreenCustomConfigState createState() => IntroScreenCustomConfigState();
}

// ------------------ Custom config ------------------
class IntroScreenCustomConfigState extends State<IntroScreenCustomConfig> {
  List<ContentConfig> listContentConfig = [];
  Color activeColor = const Color(0xff0BEEF9);
  Color inactiveColor = const Color(0xff03838b);
  double sizeIndicator = 20;

  @override
  void initState() {
    super.initState();

    listContentConfig.add(
      ContentConfig(
        title:
            "Create Your Task",
        maxLineTitle: 2,
        styleTitle: const TextStyle(
          color: Colors.white,
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'RobotoMono',
        ),
        description:
            "Create your task to make sure every task you have can completed on time",
        styleDescription: const TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontStyle: FontStyle.italic,
          fontFamily: 'Raleway',
        ),
        marginDescription: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 20.0,
          bottom: 70.0,
        ),
        centerWidget: Image.asset(AssetsConstant.introFirstImage),
        // backgroundNetworkImage: "https://picsum.photos/600/900",
        backgroundFilterOpacity: 0.5,
        backgroundFilterColor: Colors.redAccent,
        onCenterItemPress: () {},
      ),
    );
    listContentConfig.add(
      ContentConfig(
        title: "Manage your Daily Task",
        styleTitle: const TextStyle(
          color: Color(0xff7FFFD4),
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'RobotoMono',
        ),
        description:
"By using this application you will be able to manage your daily tasks",        styleDescription: const TextStyle(
          color: Color(0xff7FFFD4),
          fontSize: 20.0,
          fontStyle: FontStyle.italic,
          fontFamily: 'Raleway',
        ),
        colorBegin: const Color(0xff89D4CF),
        colorEnd: const Color(0xff734AE8),
        centerWidget: Image.asset(AssetsConstant.introSecondtImage),
        directionColorBegin: Alignment.topRight,
        directionColorEnd: Alignment.bottomLeft,
      ),
    );
    listContentConfig.add(
      ContentConfig(
        title:  "Checklist Finished Task",
        styleTitle: const TextStyle(
          // color: Color(0xffFFDAB9),
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'RobotoMono',
        ),
        description:
          "If you completed your task, so you can view the result you work for each day",
        styleDescription: const TextStyle(
          // color: Color.fromARGB(255, 153, 135, 120),
          fontSize: 20.0,
          fontStyle: FontStyle.italic,
          fontFamily: 'Raleway',
        ),
        // backgroundImage: "images/beach.jpeg",
        centerWidget: Image.asset(AssetsConstant.introThirdImage),
        maxLineTextDescription: 3,
      ),
    );
  }

  void onDonePress() {
    log("onDonePress caught");
  }

  void onNextPress() {
    log("onNextPress caught");
  }

  Widget renderNextBtn() {
    return const Icon(
      Icons.navigate_next,
      size: 25,
    );
  }

  Widget renderDoneBtn() {
    return const Icon(
      Icons.done,
      size: 25,
    );
  }

  Widget renderSkipBtn() {
    return const Icon(
      Icons.skip_next,
      size: 25,
    );
  }

  ButtonStyle myButtonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(const StadiumBorder()),
      foregroundColor: MaterialStateProperty.all<Color>(activeColor),
      backgroundColor: MaterialStateProperty.all<Color>(inactiveColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      key: UniqueKey(),
      // Content config
      listContentConfig: listContentConfig,
      backgroundColorAllTabs: Colors.grey,

      // Skip button
      renderSkipBtn: renderSkipBtn(),
      skipButtonStyle: myButtonStyle(),

      // Next button
      renderNextBtn: renderNextBtn(),
      onNextPress: onNextPress,
      nextButtonStyle: myButtonStyle(),

      // Done button
      renderDoneBtn: renderDoneBtn(),
      onDonePress: onDonePress,
      doneButtonStyle: myButtonStyle(),

      // Indicator
      indicatorConfig: IndicatorConfig(
        sizeIndicator: sizeIndicator,
        indicatorWidget: Container(
          width: sizeIndicator,
          height: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: inactiveColor,
          ),
        ),
        activeIndicatorWidget: Container(
          width: sizeIndicator,
          height: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: activeColor,
          ),
        ),
        spaceBetweenIndicator: 10,
        typeIndicatorAnimation: TypeIndicatorAnimation.sliding,
      ),

      // Navigation bar
      navigationBarConfig: NavigationBarConfig(
        navPosition: NavPosition.bottom,
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).viewPadding.top > 0 ? 20 : 10,
          bottom: MediaQuery.of(context).viewPadding.bottom > 0 ? 20 : 10,
        ),
        // backgroundColor: Colors.black.withOpacity(0.5),
      ),

      // Scroll behavior
      isAutoScroll: true,
      isLoopAutoScroll: true,
      curveScroll: Curves.bounceIn,
    );
  }
}
