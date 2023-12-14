import 'package:foodie/app/common/common_func.dart';
import 'package:foodie/app/common/widgets/common_widget.dart';
import 'package:foodie/app/data/models/food_model.dart';
import 'package:foodie/app/data/services/cart_service.dart';
import 'package:foodie/app/modules/bottom_bar/controllers/bottom_bar_controller.dart';
import 'package:foodie/app/modules/cart/controllers/cart_controller.dart';
import 'package:foodie/app/modules/home/controllers/home_controller.dart';
import 'package:foodie/app/routes/app_pages.dart';
import 'package:foodie/app/utils/strings.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  final _foodModel = FoodModel().obs;

  //Getter
  FoodModel get foodModel => _foodModel.value;

  //Setter

  final HomeController _homeController = Get.find<HomeController>();
  final CartController _cartController = Get.find<CartController>();
  final BottomBarController _bottomBarController =
      Get.find<BottomBarController>();
  //Cart service
  final CartService _cartService = Get.put(CartService());

  @override
  void onInit() {
    _foodModel.value = Get.arguments;
    super.onInit();
  }

  //add to cart
  Future<void> addToCart(
    FoodModel food,
  ) async {
    final exists = _cartController.updateQtyForFood(food.id ?? "");
    if (!exists) {
      CommonWidget.loader();
      try {
        final docId =
            await _cartService.addFoodToUserCartData(food.id ?? "", "1");
        _cartController.addFoodToCartList(food);
        _cartController.addQtyToCartQtyList("1");
        _cartController.addDocIdToList(docId);
        _bottomBarController.setCartCount(_cartController.cartFoodList.length);
        Get.back();
        CommonWidget.callSnackBar(Strings.addedToCart);
      } catch (e) {
        Get.back();
        CommonWidget.callSnackBar(e.toString(), true);
      }
    } else {
      _bottomBarController.setCartCount(_cartController.cartFoodList.length);
      CommonWidget.callSnackBar(Strings.addedToCart);
    }
  }

  //buy now
  void buyNow() {
    Get.toNamed(Routes.ORDER, arguments: {
      "foodList": [_foodModel.value],
      "qtyList": ["1"],
      "docIdList": [],
      "buyAgain": true,
    });
  }

  //updateFavStatusOnHome
  void updateFavStatusInHomeAndFavoritePage(FoodModel food) async {
    setFavoriteStatus(food);

    //when user came details page from favorite and removed it as favorite
    if (food.favorite?.value == 0) {
      removeFromHome(food.id ?? "");
    }
  }

//update home page status
  void removeFromHome(String id) {
    setStatusFav(_homeController.beveragesList, id);
    setStatusFav(_homeController.snacksList, id);
    setStatusFav(_homeController.fastFoodList, id);
    setStatusFav(_homeController.mealsList, id);
    setStatusFav(_homeController.desertsList, id);
  }

  //set status
  void setStatusFav(List<FoodModel> list, String id) async {
    for (var food in list) {
      if (id == food.id) {
        food.favorite?.value = 0;
      }
    }
  }

  //get favorite status
  bool getFavoriteStatus(FoodModel foodModel) {
    return foodModel.favorite!.value == 0 ? false : true;
  }
}
