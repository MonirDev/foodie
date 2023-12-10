import 'package:flutter/material.dart';
import 'package:foodie/app/common/widgets/custom_app_bar.dart';
import 'package:foodie/app/common/widgets/text_form_field_widget.dart';
import 'package:foodie/app/config/app_colors.dart';
import 'package:foodie/app/utils/spacer_widgets.dart';
import 'package:foodie/app/utils/strings.dart';

import 'package:get/get.dart';

import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({Key? key}) : super(key: key);
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
    return Column(
      children: [
        CustomAppbar(
          title: Strings.signUp,
          useBackBtn: true,
          backFunc: () => Get.back(),
        ),
        SpacerWidget.h15,
        _buildBodyContent(),
      ],
    );
  }

//Build Body Content
  Widget _buildBodyContent() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      width: Get.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SpacerWidget.h20,
            _buildSignUpForm(),
            SpacerWidget.h25,
            _buildSignUpButton(),
          ],
        ),
      ),
    );
  }

//Build SignUp Form
  Widget _buildSignUpForm() {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _textFiledLabel(Strings.name),
            SpacerWidget.h10,
            _buildNameTextFormField(),
            SpacerWidget.h15,
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

//Build Name TextFormField
  Widget _buildNameTextFormField() {
    return CustomTextFormField(
      controller: controller.nameController,
      onchanged: (val) {},
      hintText: Strings.enterName,
      isPassField: false,
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

//Build SignUp Button
  Widget _buildSignUpButton() {
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
        onPressed: () => controller.signUp(),
        child: Text(
          Strings.signUp,
          style: Get.textTheme.bodyLarge?.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
