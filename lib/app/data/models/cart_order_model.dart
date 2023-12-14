class CartOrderModel {
  final String? id;
  final String? foodId;
  final String? quantity;

  CartOrderModel({
    this.id,
    this.foodId,
    this.quantity,
  });

  factory CartOrderModel.fromJson(Map<String, dynamic> json) => CartOrderModel(
        id: json["id"] ?? '',
        foodId: json["foodId"] ?? '',
        quantity: json["quantity"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "foodId": foodId,
        "quantity": quantity,
      };
}
