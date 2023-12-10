import 'package:flutter/material.dart';
import 'package:foodie/app/common/widgets/common_widget.dart';
import 'package:foodie/app/routes/app_pages.dart';
import 'package:foodie/app/utils/strings.dart';
import 'package:get/get.dart';

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

  // //create a instance of FirebaseAuthService class
  // final firebaseAuthservice = FirebaseAuthService();

  // //create a instance of FirebaseCollectionService class
  // final collectionservice = CollectionService();

  @override
  void onInit() {
    super.onInit();
  }

  //go Sign Up page
  goSignupPage() {
    Get.toNamed(Routes.SIGN_UP);
  }

  //go Forget password page
  goForgetPasswordPage() {
    // Get.toNamed(Routes.for);
  }

//login
  void login() {
    // CommonWidget.loader();
    // try {
    //   validateField();
    //   Get.back();
    // } catch (e) {
    //   Get.back();
    //   CommonWidget.errorPopUp(e.toString());
    // }
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
