import 'package:flutter/material.dart';
import 'package:foodie/app/common/widgets/text_form_field_widget.dart';
import 'package:foodie/app/config/app_colors.dart';
import 'package:foodie/app/utils/spacer_widgets.dart';
import 'package:foodie/app/utils/strings.dart';

import 'package:get/get.dart';

import '../controllers/sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //For Unfocus TextField when user click outside
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: _buildBody(),
      ),
    );
  }

  //Build Body
  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpacerWidget.h15,
          _buildBodyContent(),
        ],
      ),
    );
  }

//Build Body Content
  Widget _buildBodyContent() {
    return SizedBox(
      width: Get.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SpacerWidget.h20,
            _buildHeaderText(),
            SpacerWidget.h40,
            _buildLoginForm(),
            SpacerWidget.h40,
            _buildLoginButton(),
            SpacerWidget.h15,
            _buildSignUpText(),
            SpacerWidget.h20,
          ],
        ),
      ),
    );
  }

//Build Create account
  Widget _buildSignUpText() {
    return GestureDetector(
      onTap: () => controller.goSignupPage(),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: Get.textTheme.bodySmall,
          children: [
            const TextSpan(text: "${Strings.donthaveAcc} "),
            TextSpan(
              text: Strings.signUp,
              style: Get.textTheme.bodyMedium?.copyWith(
                color: AppColors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

//Build Login Form
  Widget _buildLoginForm() {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _textFiledLabel(Strings.email),
            SpacerWidget.h10,
            _buildEmailTextFormField(),
            SpacerWidget.h15,
            _textFiledLabel(Strings.password),
            SpacerWidget.h10,
            _buildPasswordTextFormField(),
          ],
        ));
  }

  //Text Filed label text
  Widget _textFiledLabel(
    String label,
  ) {
    return Text(
      label,
      style: Get.textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: AppColors.mediumGrey,
      ),
    );
  }

  //Build Password TextFormField
  Widget _buildPasswordTextFormField() {
    return CustomTextFormField(
      controller: controller.passwordController,
      onchanged: (val) {},
      hintText: Strings.enterPassword,
      suffixEye: controller.isPassSecure
          ? Icons.visibility_off
          : Icons.visibility_sharp,
      suffixClick: () => controller.setIsPassSecure(
        controller.isPassSecure,
      ),
      isPassField: true,
      isPassSecure: controller.isPassSecure,
      contentpaddingLeft: 20,
      borderRadius: 15,
    );
  }

//Build Email TextFormField
  Widget _buildEmailTextFormField() {
    return CustomTextFormField(
      controller: controller.emailController,
      onchanged: (val) {},
      hintText: Strings.enterEmail,
      isPassField: false,
      contentpaddingLeft: 20,
      borderRadius: 15,
      inputType: TextInputType.emailAddress,
    );
  }

//Build Login Button
  Widget _buildLoginButton() {
    return SizedBox(
      width: Get.width - 40,
      height: 50,
      child: TextButton(
        style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(
            AppColors.accentColor,
          ),
          shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
            ),
          ),
        ),
        onPressed: () => controller.login(),
        child: Text(
          Strings.login,
          style: Get.textTheme.bodyLarge?.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

//Build Header Text
  Widget _buildHeaderText() {
    return Center(
      child: Text(
        Strings.login,
        style: Get.textTheme.headlineLarge?.copyWith(
          color: AppColors.accentColor,
        ),
      ),
    );
  }
}
