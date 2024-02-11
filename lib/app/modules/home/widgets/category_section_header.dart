import 'package:flutter/material.dart';
import 'package:foodie/app/config/app_colors.dart';
import 'package:foodie/app/utils/strings.dart';
import 'package:get/get.dart';

class CategorySectionHeader extends StatelessWidget {
  final String label;
  const CategorySectionHeader({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildLabel(),
        ],
      ),
    );
  }

//Build Label
  Widget _buildLabel() {
    return Text(
      label.toUpperCase(),
      style: Get.textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  //Build view all
  Widget _buildViewAll() {
    return Text(
      Strings.viewAll,
      style: Get.textTheme.bodySmall?.copyWith(
        fontWeight: FontWeight.bold,
        color: AppColors.accentColor,
      ),
    );
  }
}
