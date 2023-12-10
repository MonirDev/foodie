import 'package:flutter/material.dart';
import 'package:foodie/app/config/app_colors.dart';
import 'package:foodie/app/utils/spacer_widgets.dart';
import 'package:foodie/app/utils/strings.dart';
import 'package:get/get.dart';

class CommonWidget {
  static loader() {
    return Get.dialog(
      AlertDialog(
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: AppColors.accentColor,
                strokeWidth: 2,
              ),
            ),
            SpacerWidget.w10,
            const Text(Strings.pleaseWait),
          ],
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 25,
        ),
      ),
      barrierDismissible: false,
    );
  }

  static errorPopUp(String error) {
    return Get.dialog(
      AlertDialog(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              error,
              textAlign: TextAlign.center,
              style: Get.textTheme.bodyMedium?.copyWith(
                color: AppColors.red,
              ),
            ),
            SpacerWidget.h8,
            SizedBox(
              width: 80,
              height: 35,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {
                  Get.back();
                },
                child: const Text(
                  Strings.ok,
                ),
              ),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  static Future<dynamic> confirmationPopUp(String msg, Function ontap,
      [bool? isError]) async {
    return Get.defaultDialog(
      title: "",
      radius: 12,
      titleStyle: const TextStyle(height: 0),
      titlePadding: EdgeInsets.zero,
      actions: null,
      middleText: "",
      barrierDismissible: false,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Text(
              msg,
              textAlign: TextAlign.center,
            ),
          ),
          SpacerWidget.h5,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                    isError == true ? AppColors.darkRed : AppColors.accentColor,
                  )),
                  onPressed: () {
                    ontap();
                  },
                  child: const Text(
                    Strings.yes,
                  ),
                ),
              ),
              SpacerWidget.w15,
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(AppColors.grey),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text(
                    Strings.cancel,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      contentPadding: const EdgeInsets.only(
        right: 20,
        left: 20,
        top: 20,
      ),
    );
  }

  static Future<dynamic> responseErrorPopUp(String msg, Function retry) async {
    return Get.defaultDialog(
      title: "",
      radius: 12,
      titleStyle: const TextStyle(height: 0),
      titlePadding: EdgeInsets.zero,
      actions: null,
      middleText: "",
      barrierDismissible: false,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            Strings.errorText,
            style: Get.textTheme.titleLarge?.copyWith(
              color: AppColors.red,
            ),
          ),
          SpacerWidget.h15,
          Text(msg),
          SpacerWidget.h20,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    retry();
                  },
                  child: const Text(
                    Strings.retry,
                  ),
                ),
              ),
              SpacerWidget.w15,
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(AppColors.grey),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text(
                    Strings.cancel,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      contentPadding: const EdgeInsets.only(
        right: 20,
        left: 20,
        top: 20,
      ),
    );
  }

  static callSnackBar(String message, [bool? isError, int? durationSec]) {
    return Get.snackbar("", "",
        colorText: isError != true ? AppColors.black : AppColors.lightRed,
        titleText: Container(),
        duration: Duration(
          seconds: durationSec ?? 2,
        ),
        messageText: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (isError == true)
                      Text(
                        Strings.errorText,
                        style: Get.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: isError != true
                                ? AppColors.white
                                : AppColors.lightRed,
                            letterSpacing: 0),
                      ),
                    if (isError != true) SpacerWidget.h10,
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: Get.textTheme.bodyLarge?.copyWith(
                          color: isError != true
                              ? AppColors.white
                              : AppColors.lightRed,
                          letterSpacing: 0),
                    ),
                    SpacerWidget.h15,
                  ],
                ),
              ),
            ),
          ],
        ),
        borderRadius: 4.0,
        padding: EdgeInsets.zero,
        margin: const EdgeInsets.all(10),
        backgroundColor:
            isError != true ? AppColors.green : AppColors.snackBarBgColor,
        snackPosition: SnackPosition.BOTTOM);
  }
}
