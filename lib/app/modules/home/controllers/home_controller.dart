import 'package:get/get.dart';

class HomeController extends GetxController {
  int navigationIndex = 0;

  updateNavigationIndex(int index) {
    if (index != 2) {
      navigationIndex = index;
      update();
    }
  }
}
