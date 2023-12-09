import 'package:flutter/material.dart';
import 'package:foodie/app/config/app_colors.dart';
import 'package:foodie/app/utils/spacer_widgets.dart';
import 'package:get/get.dart';

class AppbarWithLogoTitle extends StatelessWidget {
  const AppbarWithLogoTitle({
    super.key,
    required this.title,
    this.subTitle,
    this.useBackBtn,
    this.useLogo,
    this.subTitle2,
    this.actionWidget,
    this.backFunc,
    this.useSubText,
  });
  final String title;
  final String? subTitle;
  final bool? useBackBtn;
  final bool? useLogo;
  final bool? useSubText;
  final String? subTitle2;
  final Widget? actionWidget;
  final void Function()? backFunc;

  @override
  Widget build(BuildContext context) {
    //getting statusBar height for different divice
    var statusBarHeight = MediaQuery.of(context).viewPadding.top;

    return _appBarSection(statusBarHeight);
  }

  //build AppBar section
  Widget _appBarSection(
    double statusHeight,
  ) {
    return SizedBox(
      width: Get.width,
      height: setHeight(useLogo, statusHeight),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: statusHeight),
            child: _backBtn(),
          ),
          SizedBox(
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: statusHeight,
                ),
                SpacerWidget.h8,
                _headerText(),
              ],
            ),
          ),
          Positioned(
            top: statusHeight,
            right: 0,
            child: actionWidget ?? const SizedBox(),
          ),
        ],
      ),
    );
  }

  //Back button
  Widget _backBtn() {
    return useBackBtn == true
        ? IconButton(
            onPressed: () {
              backFunc != null ? backFunc!() : Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.white,
              // size: 20,
            ))
        : const SizedBox();
  }

  //header text
  Widget _headerText() {
    return Text(
      title,
      style: Get.textTheme.headlineMedium?.copyWith(
        color: AppColors.white,
      ),
    );
  }

  double setHeight(bool? useLogo, double statusBarHeight) {
    return statusBarHeight + 70;
  }
}
