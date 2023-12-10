import 'package:get/get.dart';

class BottomBarController extends GetxController {
  final _currentIndex = 0.obs;

  int get currentIndex => _currentIndex.value;

//on tap bottom bar item
  void onItemTapped(int index) {
    _currentIndex.value = index;
  }
}
