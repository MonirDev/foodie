import 'package:flutter/material.dart';
import 'package:foodie/app/config/app_colors.dart';
import 'package:foodie/app/utils/strings.dart';
import 'package:get/get.dart';

class NotAvailable extends StatelessWidget {
  const NotAvailable({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: Get.width,
      child: Center(
        child: Text(
          Strings.notAvailable,
          style: Get.textTheme.bodyMedium?.copyWith(
            color: AppColors.darkGrey,
          ),
        ),
      ),
    );
  }
}
