import 'package:flutter/material.dart';
import 'package:foodie/app/common/widgets/common_widget.dart';
import 'package:foodie/app/utils/strings.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final _passwordTextEditingController = TextEditingController().obs;
  final _oldPasswordTextEditingController = TextEditingController().obs;

  final _isPassSecure = true.obs;
  final _isOldPassSecure = true.obs;

  //Getter
  TextEditingController get oldPasswordTextEditingController =>
      _oldPasswordTextEditingController.value;
  TextEditingController get passwordController =>
      _passwordTextEditingController.value;

  bool get isPassSecure => _isPassSecure.value;
  bool get isOldPassSecure => _isOldPassSecure.value;

  //setter
  void setIsPassSecure(bool value) => _isPassSecure.value = !value;
  void setIsOldPassSecure(bool value) => _isOldPassSecure.value = !value;

  //updatePassword
  void updatePassword() {
    CommonWidget.loader();
    try {
      validateField();
      Get.back();
    } catch (e) {
      Get.back();
      CommonWidget.errorPopUp(e.toString());
    }
  }

  //validate field
  void validateField() {
    try {
      if (_oldPasswordTextEditingController.value.text.isEmpty) {
        throw Strings.oldPassRequired;
      } else if (_passwordTextEditingController.value.text.isEmpty) {
        throw Strings.passRequired;
      } else {
        return;
      }
    } catch (e) {
      rethrow;
    }
  }
}
