import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodie/app/common/common_func.dart';
import 'package:foodie/app/data/datasource_reference/datasource_reference.dart';
import 'package:foodie/app/data/models/cart_order_model.dart';
import 'package:foodie/app/utils/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartService {
  //get user cart collection data
  Future<List<CartOrderModel>> fetchUserCartData() async {
    final pref = await SharedPreferences.getInstance();
    final userId = pref.getString(Strings.loginToken) ?? "";
    try {
      QuerySnapshot<CartOrderModel> querySnapshot =
          await DataSourceReference().userCartRef(userId).get();

      final result = querySnapshot.docs.map((doc) => doc.data()).toList();
      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  //add food to userCart data
  Future<String> addFoodToUserCartData(
    String foodId,
    String qty,
  ) async {
    final pref = await SharedPreferences.getInstance();
    final userId = pref.getString(Strings.loginToken) ?? "";
    final docId = "${Strings.appName}-${generateOrderIdString()}";
    await DataSourceReference()
        .userCartRef(userId)
        .doc(docId)
        .set(
          CartOrderModel(
            id: docId,
            foodId: foodId,
            quantity: qty,
          ),
        )
        .then(
      (_) {
        //
      },
    ).onError((error, stackTrace) {
      throw error.toString();
    });
    return docId;
  }

  //remove food to userCart data
  Future<void> removeFoodFromUserCartData(
    String docId,
  ) async {
    final pref = await SharedPreferences.getInstance();
    final userId = pref.getString(Strings.loginToken) ?? "";
    await DataSourceReference().userCartRef(userId).doc(docId).delete().then(
      (_) {
        //
      },
    ).onError((error, stackTrace) {
      throw error.toString();
    });
  }
}
