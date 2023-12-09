import 'package:flutter/material.dart';
import 'package:foodie/app/config/app_colors.dart';
import 'package:get/get.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final IconData? suffixDone;
  final IconData? suffixClose;
  final IconData? suffixEye;
  final Widget? suffixIcon;
  final bool? isValid;
  final bool? isPassField;
  final bool? isPassSecure;
  final bool? enabled;
  final bool? readOnly;
  final String? validateText;
  final String? label;
  final double? contentpaddingLeft;
  final double? borderRadius;
  final String hintText;
  final Function(String)? onchanged;
  final Function()? suffixClick;
  final void Function()? ontap;
  const CustomTextFormField({
    super.key,
    this.controller,
    this.inputType,
    this.inputAction,
    this.suffixDone,
    this.suffixClose,
    this.suffixEye,
    this.isValid,
    this.isPassField,
    this.isPassSecure,
    this.validateText,
    this.suffixClick,
    required this.onchanged,
    this.label,
    this.enabled,
    required this.hintText,
    this.suffixIcon,
    this.ontap,
    this.contentpaddingLeft,
    this.readOnly,
    this.borderRadius,
  });
  static const InputBorder transparentBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: AppColors.transparent,
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFB4B4B4),
            offset: Offset(0, 2),
            blurRadius: 5,
            spreadRadius: 0,
          ),
        ],
        border: Border.all(color: AppColors.transparent),
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius ?? 20),
        ),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        textInputAction: inputAction,
        maxLines: 1,
        enabled: enabled ?? true,
        readOnly: readOnly ?? false,
        style: Get.textTheme.bodyLarge,
        cursorColor: AppColors.black,
        obscureText: isPassSecure ?? false,
        onTap: ontap,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: Get.textTheme.bodyMedium?.copyWith(color: AppColors.grey),
          suffixIcon: suffixIcon == null && isPassField == true
              ? GestureDetector(
                  onTap: suffixClick ?? () {},
                  child: Icon(
                    suffixEye,
                    color: AppColors.grey,
                  ),
                )
              : suffixIcon,
          border: transparentBorder,
          focusedBorder: transparentBorder,
          errorBorder: transparentBorder,
          focusedErrorBorder: transparentBorder,
          disabledBorder: transparentBorder,
          enabledBorder: transparentBorder,
          contentPadding: EdgeInsets.only(left: contentpaddingLeft ?? 30),
        ),
        onChanged: onchanged,
      ),
    );
  }
}
