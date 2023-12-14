import 'package:foodie/app/common/widgets/common_widget.dart';
import 'package:foodie/app/data/models/cart_order_model.dart';
import 'package:foodie/app/data/models/food_model.dart';
import 'package:foodie/app/data/models/order_model.dart';
import 'package:foodie/app/data/services/order_service.dart';
import 'package:foodie/app/modules/home/controllers/home_controller.dart';
import 'package:foodie/app/routes/app_pages.dart';
import 'package:foodie/app/utils/strings.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  static late SharedPreferences _prefs;
  final _name = "".obs;
  final _email = "".obs;
  final _isLoading = true.obs;
  final _orderList = <CartOrderModel>[].obs;
  final _orderWithFoodItemList = <OrderModel>[].obs;

  //getter
  String get name => _name.value;
  String get email => _email.value;
  bool get isLoading => _isLoading.value;
  List<CartOrderModel> get orderList => _orderList;
  List<OrderModel> get orderWithFoodItemList => _orderWithFoodItemList;

  SharedPreferences get pref => _prefs;

  @override
  void onInit() async {
    _prefs = await SharedPreferences.getInstance();
    await getOrderCollection();
    super.onInit();
  }

  //Order service
  final OrderService _orderService = Get.put(OrderService());

  final HomeController _homeController = Get.find<HomeController>();

  //Get order collections data
  Future<void> getOrderCollection() async {
    _orderWithFoodItemList.value = [];
    _isLoading(true);
    try {
      _orderList.value = await _orderService.fetchUserOrderData();

      for (var item in _orderList) {
        var foodIdStringList = item.foodId?.split(",").toList();
        var foodQtyStringList = item.quantity?.split(",").toList();

        List<FoodModel> listOfFood = [];

        for (var i = 0; i < foodIdStringList!.length; i++) {
          final food = _homeController.listOfFoods
              .firstWhere((element) => foodIdStringList[i] == element.id);
          listOfFood.add(food);
        }
        _orderWithFoodItemList.add(
          OrderModel(
            orderId: item.id ?? "",
            qtyList: foodQtyStringList ?? [],
            foodList: listOfFood,
          ),
        );
      }

      _isLoading(false);
    } catch (e) {
      _isLoading(false);
      CommonWidget.responseErrorPopUp(
        e.toString(),
        () {
          getOrderCollection();
          Get.back();
        },
      );
    }
  }

//go to product details
  void goToProductDetails(FoodModel food) {
    Get.toNamed(
      Routes.PRODUCT_DETAILS,
      arguments: food,
    );
  }

  String getUserName() => _prefs.getString(Strings.name) ?? "";
  String getUserEmail() => _prefs.getString(Strings.email) ?? "";

  //buy again
  void buyAgain(
    List<FoodModel> foodList,
    List<String> qtyList,
  ) {
    Get.toNamed(Routes.ORDER, arguments: {
      "foodList": foodList,
      "qtyList": qtyList,
      "docIdList": [],
      "buyAgain": true,
    });
  }

  //logout
  void logout() {
    CommonWidget.confirmationPopUp(
      Strings.areUSureYouWantToLogout,
      () async {
        _prefs = await SharedPreferences.getInstance();
        _prefs.remove(Strings.keepMeLoggedIn);
        _prefs.remove(Strings.loginToken);
        _prefs.remove(Strings.name);
        _prefs.remove(Strings.email);

        Get.offAllNamed(Routes.SIGN_IN);
      },
    );
  }
}
