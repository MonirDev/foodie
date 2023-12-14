import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodie/app/common/common_func.dart';
import 'package:foodie/app/data/datasource_reference/datasource_reference.dart';
import 'package:foodie/app/data/models/cart_order_model.dart';
import 'package:foodie/app/utils/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderService {
  //get user cart collection data
  Future<List<CartOrderModel>> fetchUserOrderData() async {
    final pref = await SharedPreferences.getInstance();
    final userId = pref.getString(Strings.loginToken) ?? "";
    try {
      QuerySnapshot<CartOrderModel> querySnapshot =
          await DataSourceReference().userOrdersRef(userId).get();

      final result = querySnapshot.docs.map((doc) => doc.data()).toList();
      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  //Place Order
  Future<void> placeOrder(
    String foodIdListString,
    String qtyListString,
  ) async {
    final pref = await SharedPreferences.getInstance();
    final userId = pref.getString(Strings.loginToken) ?? "";
    final docId = "${Strings.ordersKey}-${generateOrderIdString()}";
    await DataSourceReference()
        .userOrdersRef(userId)
        .doc(docId)
        .set(
          CartOrderModel(
            id: docId,
            foodId: foodIdListString,
            quantity: qtyListString,
          ),
        )
        .then(
      (_) {
        //
      },
    ).onError((error, stackTrace) {
      throw error.toString();
    });
  }

  //Remove Order
  Future<void> removeOrder(
    String docId,
  ) async {
    final pref = await SharedPreferences.getInstance();
    final userId = pref.getString(Strings.loginToken) ?? "";
    await DataSourceReference().userOrdersRef(userId).doc(docId).delete().then(
      (_) {
        //
      },
    ).onError((error, stackTrace) {
      throw error.toString();
    });
  }
}
