import 'package:flutter/material.dart';
import 'package:foodie/app/common/widgets/common_widget.dart';
import 'package:foodie/app/data/services/user_service.dart';
import 'package:foodie/app/routes/app_pages.dart';
import 'package:foodie/app/utils/strings.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInController extends GetxController {
  final _emailTextEditingController = TextEditingController().obs;
  final _passwordTextEditingController = TextEditingController().obs;

  final _isPassSecure = true.obs;

  //Getter
  TextEditingController get emailController =>
      _emailTextEditingController.value;
  TextEditingController get passwordController =>
      _passwordTextEditingController.value;

  bool get isPassSecure => _isPassSecure.value;

  //setter
  void setIsPassSecure(bool value) => _isPassSecure.value = !value;

  //User service
  final UserService _userService = Get.put(UserService());

  //go Sign Up page
  goSignupPage() {
    Get.toNamed(Routes.SIGN_UP);
  }

  //go Forget password page
  goForgetPasswordPage() {
    Get.toNamed(Routes.FORGOT_PASSWORD);
  }

//login
  Future<void> login() async {
    CommonWidget.loader();
    try {
      validateField();
      await _userService
          .login(
        _emailTextEditingController.value.text,
        _passwordTextEditingController.value.text,
      )
          .then(
        (resp) async {
          await SharedPreferences.getInstance().then(
            (pref) async {
              //store login token
              await pref.setString(
                Strings.loginToken,
                resp.uId ?? "",
              );
              await pref.setString(
                Strings.name,
                resp.name ?? "",
              );
              await pref.setString(
                Strings.email,
                resp.email ?? "",
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
      if (_emailTextEditingController.value.text.isEmpty) {
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
