import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:foodie/app/config/app_colors.dart';
import 'package:foodie/app/utils/strings.dart';

import 'package:get/get.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  SplashScreenView({Key? key}) : super(key: key);
  @override
  final SplashScreenController controller = Get.put(SplashScreenController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.accent2,
        body: _buildBody(),
      ),
    );
  }

//Build Body with TweenAnimationBuilder
  Widget _buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const SizedBox(),
        Text(
          Strings.appName,
          style: Get.textTheme.headlineLarge?.copyWith(
            color: AppColors.white,
          ),
        ),
        const Center(
          child: SpinKitThreeInOut(
            color: AppColors.white,
            size: 25,
          ),
        ),
      ],
    );
  }
}
