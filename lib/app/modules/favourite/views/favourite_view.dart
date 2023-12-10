import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/favourite_controller.dart';

class FavouriteView extends GetView<FavouriteController> {
  FavouriteView({Key? key}) : super(key: key);
  @override
  final FavouriteController controller = Get.put(FavouriteController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text(
          'FavouriteView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
