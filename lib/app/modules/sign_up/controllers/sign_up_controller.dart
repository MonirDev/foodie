import 'package:flutter/material.dart';
import 'package:foodie/app/common/widgets/common_widget.dart';
import 'package:foodie/app/utils/strings.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final _nameTextEditingController = TextEditingController().obs;
  final _emailTextEditingController = TextEditingController().obs;
  final _passwordTextEditingController = TextEditingController().obs;

  final _isPassSecure = true.obs;

  //Getter
  TextEditingController get nameController => _nameTextEditingController.value;
  TextEditingController get emailController =>
      _emailTextEditingController.value;
  TextEditingController get passwordController =>
      _passwordTextEditingController.value;

  bool get isPassSecure => _isPassSecure.value;

  //setter
  void setIsPassSecure(bool value) => _isPassSecure.value = !value;

  //signup
  void signUp() {
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
      if (_nameTextEditingController.value.text.isEmpty) {
        throw Strings.nameRequired;
      } else if (_emailTextEditingController.value.text.isEmpty) {
        throw Strings.emailRequired;
      } else if (!GetUtils.isEmail(_emailTextEditingController.value.text)) {
        throw Strings.emailInvalid;
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
