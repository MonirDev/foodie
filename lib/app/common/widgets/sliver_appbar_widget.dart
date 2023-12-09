import 'package:flutter/material.dart';
import 'package:foodie/app/config/app_colors.dart';
import 'package:get/get.dart';

class SliverAppBarWidget extends StatelessWidget {
  final String? titleText;
  final double? elevation;
  final Color? bgColor;
  const SliverAppBarWidget(
      {super.key, this.titleText, this.elevation, this.bgColor});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: elevation,
      leading: GestureDetector(
        onTap: () => Get.back(),
        child: const Icon(
          Icons.arrow_back_ios,
          size: 20,
          color: AppColors.accentColor,
        ),
      ),
      backgroundColor: bgColor ?? AppColors.primaryColor,
      floating: true,
    );
  }
}
