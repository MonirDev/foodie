import 'package:flutter/material.dart';
import 'package:foodie/app/common/common_func.dart';
import 'package:foodie/app/common/widgets/common_widget.dart';
import 'package:foodie/app/data/services/user_service.dart';
import 'package:foodie/app/routes/app_pages.dart';
import 'package:foodie/app/utils/strings.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  //User service
  final UserService _userService = Get.put(UserService());

  //signup
  Future<void> signUp() async {
    CommonWidget.loader();
    final uId = generateRandomString();
    try {
      validateField();
      await _userService
          .uploadUserData(
        uId,
        _nameTextEditingController.value.text,
        _emailTextEditingController.value.text,
        _passwordTextEditingController.value.text,
      )
          .then(
        (_) async {
          await SharedPreferences.getInstance().then(
            (pref) async {
              //store login token
              await pref.setString(
                Strings.loginToken,
                uId,
              );

              await pref.setString(
                Strings.name,
                _nameTextEditingController.value.text,
              );
              await pref.setString(
                Strings.email,
                _emailTextEditingController.value.text,
              );
              //store keepLoggedIn status
              await pref.setBool(
                Strings.keepMeLoggedIn,
                true,
              );
            },
          );

          //
          Get.back();
          CommonWidget.callSnackBar(Strings.registrationCompleted);
          goToHomePage();
        },
      );
    } catch (e) {
      Get.back();
      CommonWidget.callSnackBar(e.toString(), true);
    }
  }

  //goTOHome page
  void goToHomePage() {
    Get.offAllNamed(Routes.BOTTOM_BAR);
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
