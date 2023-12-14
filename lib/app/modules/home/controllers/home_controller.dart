import 'package:foodie/app/common/common_func.dart';
import 'package:foodie/app/common/widgets/common_widget.dart';
import 'package:foodie/app/data/models/food_model.dart';
import 'package:foodie/app/data/services/product_service.dart';
import 'package:foodie/app/routes/app_pages.dart';
import 'package:foodie/app/utils/strings.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final _listOfFoods = <FoodModel>[].obs;

  final _beveragesList = <FoodModel>[].obs;
  final _snacksList = <FoodModel>[].obs;
  final _fastFoodList = <FoodModel>[].obs;
  final _mealsList = <FoodModel>[].obs;
  final _desertsList = <FoodModel>[].obs;

  final _favoriteList = <FoodModel>[].obs;
  final _isLoading = true.obs;

//getter
  List<FoodModel> get listOfFoods => _listOfFoods;
  List<FoodModel> get beveragesList => _beveragesList;
  List<FoodModel> get snacksList => _snacksList;
  List<FoodModel> get fastFoodList => _fastFoodList;
  List<FoodModel> get mealsList => _mealsList;
  List<FoodModel> get desertsList => _desertsList;

  List<FoodModel> get favoriteList => _favoriteList;
  bool get isLoading => _isLoading.value;

  //setter
  void setFavoriteFoodList(List<FoodModel> list) {
    _favoriteList.value = list;
  }

  //product service
  final ProductService _productService = Get.put(ProductService());

  @override
  void onInit() async {
    await getAllFoodCollectionData();
    super.onInit();
  }

  //Get all food collections data
  Future<void> getAllFoodCollectionData() async {
    _isLoading(true);
    try {
      _listOfFoods.value = await _productService.fetchFoodCollectionData();
      setFoodsToCategoryList();
      _isLoading(false);
    } catch (e) {
      _isLoading(false);
      CommonWidget.responseErrorPopUp(
        e.toString(),
        () {
          getAllFoodCollectionData();
          Get.back();
        },
      );
    }
  }

//get favorite status
  bool getFavoriteStatus(FoodModel foodModel) {
    return foodModel.favorite!.value == 0 ? false : true;
  }

//set favorite status
  void setFoodsToCategoryList() {
    for (var food in _listOfFoods) {
      switch (food.category) {
        case Strings.beverages:
          _beveragesList.add(food);
          break;
        case Strings.snacks:
          _snacksList.add(food);
          break;
        case Strings.fastFood:
          _fastFoodList.add(food);
          break;
        case Strings.meals:
          _mealsList.add(food);
          break;
        case Strings.deserts:
          _desertsList.add(food);
          break;
        default:
      }
      updateFavStatus(food.id ?? "");
    }
  }

  //go to product details
  void goToProductDetails(FoodModel food) {
    Get.toNamed(
      Routes.PRODUCT_DETAILS,
      arguments: food,
    );
  }

  //update favorite status on first loading of the app
  void updateFavStatus(String id) {
    setStatusFav(_beveragesList, id);
    setStatusFav(_snacksList, id);
    setStatusFav(_fastFoodList, id);
    setStatusFav(_mealsList, id);
    setStatusFav(_desertsList, id);
  }

  //set status
  void setStatusFav(RxList<FoodModel> list, String id) async {
    final favList = await getFavFoodFromOfflineDB();

    var item = FoodModel();

    for (var element in favList) {
      if (element.id == id) {
        item = element;
      }
    }

    for (var food in list) {
      if (item.id == food.id) {
        food.favorite?.value = 1;
      }
    }
  }
}
