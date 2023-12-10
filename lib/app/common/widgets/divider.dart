import 'package:flutter/material.dart';
import 'package:foodie/app/config/app_colors.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key, this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color ?? AppColors.white.withOpacity(0.6),
      thickness: 1.5,
      height: 1,
    );
  }
}
