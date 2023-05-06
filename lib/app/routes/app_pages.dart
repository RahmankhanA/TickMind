import 'package:get/get.dart';

import '../modules/authentication/bindings/authentication_binding.dart';
import '../modules/authentication/views/authentication_view.dart';
import '../modules/calender/bindings/calender_binding.dart';
import '../modules/calender/views/calender_view.dart';
import '../modules/category_details/bindings/category_details_binding.dart';
import '../modules/category_details/views/category_details_view.dart';
import '../modules/createTask/bindings/create_task_binding.dart';
import '../modules/createTask/views/create_task_view.dart';
import '../modules/history/bindings/history_binding.dart';
import '../modules/history/views/history_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/intro/bindings/intro_binding.dart';
import '../modules/intro/views/intro.dart';
import '../modules/main/bindings/main_binding.dart';
import '../modules/main/views/main_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.AUTHENTICATION;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.INTRO,
      page: () => const IntroScreenCustomConfig(),
      // page: () => const IntroView(),
      binding: IntroBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_TASK,
      page: () => const CreateTaskView(),
      binding: CreateTaskBinding(),
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () => const MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: _Paths.CALENDER,
      page: () => const CalenderView(),
      binding: CalenderBinding(),
    ),
    GetPage(
      name: _Paths.HISTORY,
      page: () => const HistoryView(),
      binding: HistoryBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.AUTHENTICATION,
      page: () => const AuthenticationView(),
      binding: AuthenticationBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORY_DETAILS,
      page: () => const CategoryDetailsView(),
      binding: CategoryDetailsBinding(),
    ),
  ];
}
