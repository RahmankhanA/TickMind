import 'package:get/get.dart';
import 'package:ticmind/app/modules/calender/controllers/calender_controller.dart';
import 'package:ticmind/app/modules/history/controllers/history_controller.dart';
import 'package:ticmind/app/modules/main/controllers/main_controller.dart';
import 'package:ticmind/app/modules/profile/controllers/profile_controller.dart';

class HomeController extends GetxController {
  RxInt navigationIndex = 0.obs;
  MainController mainController=Get.put(MainController());
  CalenderController calenderController=Get.put(CalenderController());
  HistoryController historyController=Get.put(HistoryController());
  ProfileController profileController=Get.put(ProfileController());

  updateNavigationIndex(int index) {
    if (index != 2) {
      navigationIndex.value = index;
      update();
    }
  }
}
