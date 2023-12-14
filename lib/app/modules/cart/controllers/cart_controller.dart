import 'package:foodie/app/common/widgets/common_widget.dart';
import 'package:foodie/app/data/models/food_model.dart';
import 'package:foodie/app/data/services/cart_service.dart';
import 'package:foodie/app/modules/bottom_bar/controllers/bottom_bar_controller.dart';
import 'package:foodie/app/modules/home/controllers/home_controller.dart';
import 'package:foodie/app/routes/app_pages.dart';
import 'package:foodie/app/utils/strings.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final _cartFoodList = <FoodModel>[].obs;
  final _cartFoodQty = <String>[].obs;
  final _cartFoodDocIdList = <String>[].obs;

  final _isLoading = true.obs;

  //Getter
  List<FoodModel> get cartFoodList => _cartFoodList;
  List<String> get cartFoodQty => _cartFoodQty;
  List<String> get cartFoodDocIdList => _cartFoodDocIdList;

  bool get isLoading => _isLoading.value;
  //setter
  void setCartFoodList(List<FoodModel> list) => _cartFoodList.value = list;
  void setCartFoodQtyList(List<String> list) => _cartFoodQty.value = list;
  void setCartFoodDocIdList(List<String> list) =>
      _cartFoodDocIdList.value = list;
  void addFoodToCartList(FoodModel food) => _cartFoodList.add(food);
  void addQtyToCartQtyList(String qty) => _cartFoodQty.add(qty);
  void addDocIdToList(String docId) => _cartFoodDocIdList.add(docId);

  @override
  void onInit() async {
    await getCartFoodCollectionData();
    super.onInit();
  }

  //Cart service
  final CartService _cartService = Get.put(CartService());
  final HomeController _homeController = Get.find<HomeController>();
  final BottomBarController _bottomBarController =
      Get.find<BottomBarController>();

  //Get all cart food collections data
  Future<void> getCartFoodCollectionData() async {
    _isLoading(true);
    try {
      final cartValue = await _cartService.fetchUserCartData();

      for (var item in cartValue) {
        final foodItem = _homeController.listOfFoods.firstWhere(
          (element) => item.foodId == element.id,
          orElse: () => FoodModel(),
        );
        if (foodItem.id != null) {
          _cartFoodList.add(foodItem);
          _cartFoodQty.add("1");
          _cartFoodDocIdList.add(item.id ?? "");
        }
      }
      _bottomBarController.setCartCount(_cartFoodList.length);
      _isLoading(false);
    } catch (e) {
      _isLoading(false);
      CommonWidget.responseErrorPopUp(
        e.toString(),
        () {
          getCartFoodCollectionData();
          Get.back();
        },
      );
    }
  }

  //remove food item from cart
  Future<void> removeFoodItem(int index) async {
    CommonWidget.loader();
    try {
      await _cartService.removeFoodFromUserCartData(_cartFoodDocIdList[index]);

      _cartFoodList.removeAt(index);
      _cartFoodQty.removeAt(index);
      _cartFoodDocIdList.removeAt(index);
      _bottomBarController.setCartCount(_cartFoodList.length);
      Get.back();
      CommonWidget.callSnackBar(Strings.removedFromCart);
    } catch (e) {
      Get.back();
      CommonWidget.callSnackBar(e.toString(), true);
    }
  }

  //checkout
  void checkOut() {
    final foodList = List.from(_cartFoodList);
    final qtyList = List.from(_cartFoodQty);
    final docIdList = List.from(_cartFoodDocIdList);
    Get.toNamed(Routes.ORDER, arguments: {
      "foodList": foodList,
      "qtyList": qtyList,
      "docIdList": docIdList,
      "buyAgain": false,
    });
  }

  //go to product details
  void goToProductDetails(FoodModel food) {
    Get.toNamed(
      Routes.PRODUCT_DETAILS,
      arguments: food,
    );
  }

  //get qty*price value for a Food item
  double getQtyPrice(double price, String qty) {
    return price * double.parse(qty);
  }

  //get total price
  double getTotalPriceOfCart() {
    var totalValue = 0.0;
    for (var i = 0; i < _cartFoodList.length; i++) {
      totalValue +=
          (_cartFoodList[i].price ?? 0.0) * double.parse(_cartFoodQty[i]);
    }
    return totalValue;
  }

  //update food qty if duplicate
  bool updateQtyForFood(String id) {
    final foodIndex = _cartFoodList.indexWhere((element) => element.id == id);

    if (foodIndex < 0) {
      return false;
    } else {
      _cartFoodQty[foodIndex] =
          (int.parse(_cartFoodQty[foodIndex]) + 1).toString();
      return true;
    }
  }

//increase
  void increase(int index) {
    _cartFoodQty[index] = (int.parse(_cartFoodQty[index]) + 1).toString();
  }

//decrease
  void decrease(int index) {
    if (_cartFoodQty[index] != "1") {
      _cartFoodQty[index] = (int.parse(_cartFoodQty[index]) - 1).toString();
    }
  }
}
