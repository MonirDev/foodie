import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodie/app/data/models/cart_order_model.dart';
import 'package:foodie/app/data/models/food_model.dart';
import 'package:foodie/app/data/models/user_model.dart';
import 'package:foodie/app/utils/strings.dart';

class DataSourceReference {
  //db instance
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  //Food collections reference
  static final foodCollectionsRef =
      _db.collection(Strings.foodCollectionsKey).withConverter<FoodModel>(
            fromFirestore: (snapshot, _) => FoodModel.fromJson(
              snapshot.data()!,
            ),
            toFirestore: (food, _) => food.toJson(),
          );

  //Create a Users collection reference
  static final userRef =
      _db.collection(Strings.usersKey).withConverter<UserModel>(
            fromFirestore: (snapshot, _) => UserModel.fromJson(
              snapshot.data()!,
            ),
            toFirestore: (user, _) => user.toJson(),
          );

  //Create a User Carts collection reference
  CollectionReference<CartOrderModel> userCartRef(String userId) {
    return _db
        .collection(Strings.usersKey)
        .doc(userId)
        .collection(Strings.cartsKey)
        .withConverter<CartOrderModel>(
          fromFirestore: (snapshot, _) =>
              CartOrderModel.fromJson(snapshot.data()!),
          toFirestore: (cart, _) => cart.toJson(),
        );
  }

  //Create a User Orders collection reference
  CollectionReference<CartOrderModel> userOrdersRef(String userId) {
    return _db
        .collection(Strings.usersKey)
        .doc(userId)
        .collection(Strings.ordersKey)
        .withConverter<CartOrderModel>(
          fromFirestore: (snapshot, _) =>
              CartOrderModel.fromJson(snapshot.data()!),
          toFirestore: (cart, _) => cart.toJson(),
        );
  }
}
