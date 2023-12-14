import 'package:foodie/app/common/widgets/common_widget.dart';
import 'package:foodie/app/data/models/food_model.dart';
import 'package:foodie/app/data/services/cart_service.dart';
import 'package:foodie/app/data/services/order_service.dart';
import 'package:foodie/app/modules/bottom_bar/controllers/bottom_bar_controller.dart';
import 'package:foodie/app/modules/cart/controllers/cart_controller.dart';
import 'package:foodie/app/modules/profile/controllers/profile_controller.dart';
import 'package:foodie/app/utils/strings.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  final _cartFoodList = <FoodModel>[].obs;
  final _cartFoodQty = <String>[].obs;
  final _cartFoodDocIdList = <String>[].obs;
  final _buyAgain = false.obs;

  final arguments = Get.arguments;

  //Getter
  List<FoodModel> get cartFoodList => _cartFoodList;
  List<String> get cartFoodQty => _cartFoodQty;
  List<String> get cartFoodDocIdList => _cartFoodDocIdList;
  bool get buyAgain => _buyAgain.value;

  //setter
  void setCartFoodList(List<FoodModel> list) => _cartFoodList.value = list;
  void addFoodToCartList(FoodModel food) => _cartFoodList.add(food);

  @override
  void onInit() async {
    if (arguments != null) {
      _cartFoodList.value = List.from(arguments["foodList"]);
      _cartFoodQty.value = List.from(arguments["qtyList"]);
      _cartFoodDocIdList.value = List.from(arguments["docIdList"]);
      _buyAgain.value = arguments["buyAgain"];
    }
    super.onInit();
  }

  //Order service
  final OrderService _orderService = Get.put(OrderService());
  final CartService _cartService = Get.put(CartService());
  final CartController _cartController = Get.find<CartController>();
  final ProfileController _profileController = Get.find<ProfileController>();
  final BottomBarController _bottomBarController =
      Get.find<BottomBarController>();

  //place order
  Future<void> placeOrder([bool? buyAgain]) async {
    final foodIdListString = _cartFoodList.fold(
        "",
        (previousValue, element) => previousValue.isEmpty
            ? element.id ?? ""
            : "$previousValue,${element.id}");
    final qtyListString = _cartFoodQty.fold(
        "",
        (previousValue, element) =>
            previousValue.isEmpty ? element : "$previousValue,$element");
    CommonWidget.loader();

    try {
      await _orderService.placeOrder(foodIdListString, qtyListString);

      if (!_buyAgain.value) {
        for (var food in _cartFoodList) {
          final indexOfCartPageFood = _cartController.cartFoodList
              .indexWhere((element) => element.id == food.id);
          if (indexOfCartPageFood > -1) {
            _cartController.cartFoodList.removeAt(indexOfCartPageFood);
            _cartController.cartFoodQty.removeAt(indexOfCartPageFood);
            _cartController.cartFoodDocIdList.removeAt(indexOfCartPageFood);
            _bottomBarController
                .setCartCount(_cartController.cartFoodList.length);
          }
        }

        //remove from DB
        for (var docId in _cartFoodDocIdList) {
          await _cartService.removeFoodFromUserCartData(docId);
        }
      }
      await _profileController.getOrderCollection();
      Get.back();
      Get.back();
      CommonWidget.callSnackBar(Strings.thankYouForYourOrder);
    } catch (e) {
      Get.back();
      CommonWidget.callSnackBar(e.toString(), true);
    }
  }

  //remove food item from cart
  Future<void> removeFoodItem(int index) async {
    _cartFoodList.removeAt(index);
    _cartFoodQty.removeAt(index);
    _cartFoodDocIdList.removeAt(index);
    if (_cartFoodList.isEmpty) {
      Get.back();
    }
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

  //get total item
  String totalItem() {
    final itemCount = _cartFoodQty.fold(
        0, (previousValue, element) => previousValue + int.parse(element));
    return itemCount.toString();
  }
}
