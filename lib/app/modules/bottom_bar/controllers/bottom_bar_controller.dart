import 'package:foodie/app/common/common_func.dart';
import 'package:get/get.dart';

class BottomBarController extends GetxController {
  final _currentIndex = 0.obs;
  final _favoriteCount = 0.obs;
  final _cartCount = 0.obs;

//getter
  int get currentIndex => _currentIndex.value;
  int get favoriteCount => _favoriteCount.value;
  int get cartCount => _cartCount.value;

  //setter
  void setFavCount(int value) => _favoriteCount.value = value;
  void setCartCount(int value) => _cartCount.value = value;

  @override
  void onInit() async {
    final favList = await getFavFoodFromOfflineDB();
    _favoriteCount.value = favList.length;
    super.onInit();
  }

//on tap bottom bar item
  void onItemTapped(int index) {
    _currentIndex.value = index;
  }
}
