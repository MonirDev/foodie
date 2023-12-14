import 'dart:math';

import 'package:foodie/app/data/models/food_model.dart';
import 'package:foodie/app/data/offline_db/db_helper.dart';
import 'package:foodie/app/modules/bottom_bar/controllers/bottom_bar_controller.dart';
import 'package:foodie/app/modules/favourite/controllers/favourite_controller.dart';
import 'package:get/get.dart';

///[OfflineDB]
//add Food to offline DB
void addFoodToOfflineDB(FoodModel food) async {
  var dbHelper = DatabaseHelper();
  final jsonData = food.toJson();

  await dbHelper.addFood(jsonData);
}

//remove Food From offline DB
Future<bool> removeFoodFromOfflineDB(String id) async {
  var dbHelper = DatabaseHelper();

  int deletedRows = await dbHelper.deleteProduct(id);

  return deletedRows > 0 ? true : false;
}

//get Favorite Food From offline DB
Future<List<FoodModel>> getFavFoodFromOfflineDB() async {
  var dbHelper = DatabaseHelper();

  var result = await dbHelper.getFavorites();

  var list = <FoodModel>[];

  for (var food in result) {
    list.add(FoodModel.fromJson(food));
  }

  return list;
}

/// [Others]
///
void setFavoriteStatus(FoodModel foodModel) async {
  if (foodModel.favorite?.value == 0) {
    foodModel.favorite?.value = 1;
    addFoodToOfflineDB(foodModel);
  } else {
    foodModel.favorite?.value = 0;
    removeFoodFromOfflineDB(foodModel.id ?? "");
  }
  final list = await getFavFoodFromOfflineDB();
  _bottomBarController.setFavCount(list.length);
  _favouriteController.setFavoriteFoodList(list);
}

//Favorite controller
final FavouriteController _favouriteController =
    Get.find<FavouriteController>();
//BottomBar controller
final BottomBarController _bottomBarController =
    Get.find<BottomBarController>();

String generateRandomString() {
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  final random = Random();
  return String.fromCharCodes(
    Iterable.generate(
        10, (_) => chars.codeUnitAt(random.nextInt(chars.length))),
  );
}

String generateOrderIdString() {
  const chars = '0123456789';
  final random = Random();
  return String.fromCharCodes(
    Iterable.generate(
      5,
      (_) => chars.codeUnitAt(
        random.nextInt(chars.length),
      ),
    ),
  );
}
