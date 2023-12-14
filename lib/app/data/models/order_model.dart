import 'package:foodie/app/data/models/food_model.dart';

class OrderModel {
  final String orderId;
  final List<String> qtyList;
  final List<FoodModel> foodList;
  OrderModel({
    required this.orderId,
    required this.qtyList,
    required this.foodList,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        orderId: json["orderId"],
        qtyList: json["qtyList"],
        foodList: json["foodList"],
      );
}
