import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpacerWidget {
  //Height**************************
  static var h100 = const SizedBox(
    height: 100,
  );
  static var h60 = const SizedBox(
    height: 60,
  );
  static var h50 = const SizedBox(
    height: 50,
  );
  static var h40 = const SizedBox(
    height: 40,
  );
  static var h30 = const SizedBox(
    height: 30,
  );
  static var h25 = const SizedBox(
    height: 25,
  );
  static var h20 = const SizedBox(
    height: 20,
  );
  static var h15 = const SizedBox(
    height: 15,
  );
  static var h10 = const SizedBox(
    height: 10,
  );
  static var h8 = const SizedBox(
    height: 8,
  );
  static var h6 = const SizedBox(
    height: 6,
  );
  static var h5 = const SizedBox(
    height: 5,
  );

  //Width**************************
  static var w50 = const SizedBox(
    width: 50,
  );
  static var w40 = const SizedBox(
    width: 40,
  );
  static var w30 = const SizedBox(
    width: 30,
  );
  static var w20 = const SizedBox(
    width: 20,
  );
  static var w15 = const SizedBox(
    width: 15,
  );
  static var w10 = const SizedBox(
    width: 10,
  );
  static var w8 = const SizedBox(
    width: 8,
  );
  static var w6 = const SizedBox(
    width: 6,
  );
  static var w5 = const SizedBox(
    width: 5,
  );

  static var appBarHeight = SizedBox(
    height: AppBar().preferredSize.height,
  );
  static var statusBarHeight = SizedBox(
    height: Get.context?.mediaQueryPadding.top,
  );
}
