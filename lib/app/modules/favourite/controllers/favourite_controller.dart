import 'package:foodie/app/common/common_func.dart';
import 'package:foodie/app/data/models/food_model.dart';
import 'package:foodie/app/modules/bottom_bar/controllers/bottom_bar_controller.dart';
import 'package:foodie/app/modules/home/controllers/home_controller.dart';
import 'package:foodie/app/routes/app_pages.dart';
import 'package:get/get.dart';

class FavouriteController extends GetxController {
  final _favoriteList = <FoodModel>[].obs;

//getter
  List<FoodModel> get favoriteList => _favoriteList;

  //Setter
  void setFavoriteFoodList(List<FoodModel> list) {
    _favoriteList.value = list;
  }

  //Home controller
  final HomeController _homeController = Get.find<HomeController>();
  //BottomBar controller
  final BottomBarController _bottomBarController =
      Get.find<BottomBarController>();

  @override
  void onInit() async {
    final list = await getFavFoodFromOfflineDB();
    _favoriteList.value = list;
    super.onInit();
  }

  //go to product details
  void goToProductDetails(FoodModel food) {
    Get.toNamed(
      Routes.PRODUCT_DETAILS,
      arguments: food,
    );
  }

  //remove food
  void removeFoodFromList(String id) async {
    await removeFoodFromOfflineDB(id);
    final list = await getFavFoodFromOfflineDB();

    _favoriteList.value = list;
    updateFavStatusInHomePage(id);

    //update bottombar fav count
    _bottomBarController.setFavCount(list.length);
  }

  //update favorite status on home page
  void updateFavStatusInHomePage(String id) {
    setStatusFav(_homeController.beveragesList, id);
    setStatusFav(_homeController.snacksList, id);
    setStatusFav(_homeController.fastFoodList, id);
    setStatusFav(_homeController.mealsList, id);
    setStatusFav(_homeController.desertsList, id);
  }

  //set status
  void setStatusFav(List<FoodModel> list, String id) {
    for (var item in list) {
      if (item.id == id) {
        item.favorite?.value = 0;
      }
    }
  }

  //
}
