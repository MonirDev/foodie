// To parse this JSON data, do
//
//     final FoodModel = foodModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

FoodModel foodModelFromJson(String str) => FoodModel.fromJson(json.decode(str));

String foodModelToJson(FoodModel data) => json.encode(data.toJson());

class FoodModel {
  final String? id;
  final String? title;
  final String? description;
  final double? price;
  final String? imgUrl;
  final String? category;
  final double? ratings;
  RxInt? favorite;

  FoodModel({
    this.id,
    this.title,
    this.description,
    this.price,
    this.imgUrl,
    this.category,
    this.ratings,
    this.favorite,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) => FoodModel(
        id: json["id"] ?? "",
        title: json["title"] ?? "",
        description: json["description"] ?? "",
        price: double.tryParse(json["price"].toString()) ?? 0.0,
        imgUrl: json["imgUrl"] ?? "",
        category: json["category"] ?? "",
        ratings: double.tryParse(json["ratings"].toString()) ?? 0.0,
        favorite: json["favorite"] == 1 ? 1.obs : 0.obs,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "price": price,
        "imgUrl": imgUrl,
        "category": category,
        "ratings": ratings,
        "favorite": favorite!.value,
      };
}
