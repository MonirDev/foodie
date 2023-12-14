import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:foodie/app/config/app_colors.dart';
import 'package:foodie/app/utils/app_constants.dart';

import 'package:get/get.dart';

import '../controllers/bottom_bar_controller.dart';

class BottomBarView extends GetView<BottomBarController> {
  const BottomBarView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Constants.screens[controller.currentIndex],
      ),
      bottomNavigationBar: Obx(
        () => ConvexAppBar.badge(
          {
            1: controller.favoriteCount.toString(),
            2: controller.cartCount.toString(),
          },
          badgeMargin: const EdgeInsets.only(bottom: 25, left: 20),
          style: TabStyle.react,
          items: Constants.tabItemList,
          backgroundColor: AppColors.white,
          color: AppColors.accentColor.withOpacity(0.8),
          activeColor: AppColors.accentColor,
          badgeColor: AppColors.darkRed,
          initialActiveIndex: controller.currentIndex,
          onTap: (int i) => controller.onItemTapped(i),
        ),
      ),
    );
  }
}
