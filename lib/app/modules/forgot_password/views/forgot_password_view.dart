import 'package:flutter/material.dart';
import 'package:foodie/app/common/widgets/custom_app_bar.dart';
import 'package:foodie/app/common/widgets/text_form_field_widget.dart';
import 'package:foodie/app/config/app_colors.dart';
import 'package:foodie/app/utils/spacer_widgets.dart';
import 'package:foodie/app/utils/strings.dart';

import 'package:get/get.dart';

import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({Key? key}) : super(key: key);
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
          title: Strings.resetPassword,
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
            _buildForgotPassForm(),
            SpacerWidget.h30,
            _buildUpdatePasswordButton(),
          ],
        ),
      ),
    );
  }

//Build ForgotPass Form
  Widget _buildForgotPassForm() {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _textFiledLabel(Strings.oldPassword),
            SpacerWidget.h10,
            _buildOldPasswordTextFormField(),
            SpacerWidget.h15,
            _textFiledLabel(Strings.newPassword),
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

  //Build OldPassword TextFormField
  Widget _buildOldPasswordTextFormField() {
    return CustomTextFormField(
      controller: controller.oldPasswordTextEditingController,
      onchanged: (val) {},
      hintText: Strings.enterOldPass,
      suffixEye: controller.isOldPassSecure
          ? Icons.visibility_off
          : Icons.visibility_sharp,
      suffixClick: () => controller.setIsOldPassSecure(
        controller.isOldPassSecure,
      ),
      isPassField: true,
      isPassSecure: controller.isOldPassSecure,
      contentpaddingLeft: 20,
      borderRadius: 15,
    );
  }

  //Build Password TextFormField
  Widget _buildPasswordTextFormField() {
    return CustomTextFormField(
      controller: controller.passwordController,
      onchanged: (val) {},
      hintText: Strings.enterNewPass,
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

//Build UpdatePassword Button
  Widget _buildUpdatePasswordButton() {
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
        onPressed: () => controller.updatePassword(),
        child: Text(
          Strings.updatePassword,
          style: Get.textTheme.bodyLarge?.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
