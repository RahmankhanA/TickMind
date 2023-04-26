import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ticmind/app/core/local_db/task_hive_model.dart';
import 'package:ticmind/app/core/local_db/user_hive_model.dart';
import 'package:ticmind/app/modules/home/controllers/home_controller.dart';

import 'app/routes/app_pages.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

// Ideal time to initialize
  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  Hive.registerAdapter(UserModelAdapter());
  Hive.openBox;
  Get.put(HomeController());
  runApp(
    GetMaterialApp(
// This theme was made for FlexColorScheme version 6.1.1. Make sure
// you use same or higher version, but still same major version. If
// you use a lower version, some properties may not be supported. In
// that case you can also remove them after copying the theme to your app.
      theme: FlexThemeData.light(
        scheme: FlexScheme.blue,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 9,
        swapColors: true,
        appBarElevation: 0,
        subThemesData: const FlexSubThemesData(
          useFlutterDefaults: true,
          elevatedButtonRadius: 20.0,
          elevatedButtonSchemeColor: SchemeColor.onPrimary,
          elevatedButtonSecondarySchemeColor: SchemeColor.primary,
          sliderValueTinted: true,
        ),
        keyColors: const FlexKeyColors(),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
        // To use the playground font, add GoogleFonts package and uncomment
        // fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.blue,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 15,
        appBarElevation: 0,
        subThemesData: const FlexSubThemesData(
          useFlutterDefaults: true,
          elevatedButtonRadius: 20.0,
          elevatedButtonSchemeColor: SchemeColor.onPrimary,
          elevatedButtonSecondarySchemeColor: SchemeColor.primary,
          sliderValueTinted: true,
        ),
        keyColors: const FlexKeyColors(),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
        // To use the Playground font, add GoogleFonts package and uncomment
        // fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
// If you do not have a themeMode switch, uncomment this line
// to let the device system mode control the theme mode:
// themeMode: ThemeMode.system,



      // Use dark or light theme based on system setting.
      themeMode: ThemeMode.system,
      title: "TickMind",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
