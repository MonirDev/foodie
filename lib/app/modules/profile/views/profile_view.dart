import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:foodie/app/common/widgets/custom_app_bar.dart';
import 'package:foodie/app/common/widgets/not_available.dart';
import 'package:foodie/app/config/app_colors.dart';
import 'package:foodie/app/utils/spacer_widgets.dart';
import 'package:foodie/app/utils/strings.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({Key? key}) : super(key: key);
  @override
  final ProfileController controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: _buildBody(),
    );
  }

  //Build Body
  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const CustomAppbar(
          title: Strings.profile,
          useBackBtn: false,
        ),
        SpacerWidget.h10,
        _userDescription(),
        SpacerWidget.h20,
        _label(Strings.myOrders),
        SpacerWidget.h10,
        _orderList(),
      ],
    );
  }

  //Order list
  Widget _orderList() {
    return Expanded(
      child: Obx(
        () => controller.isLoading
            ? _buildLoader()
            : controller.orderList.isEmpty
                ? const NotAvailable()
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 20),
                    itemCount: controller.orderList.length,
                    itemBuilder: (ctx, i) => _orderItem(i),
                  ),
      ),
    );
  }

  //order list
  Widget _orderItem(int orderIndex) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _orderItemList(orderIndex),
          _buildBuyAgainButton(orderIndex),
        ],
      ),
    );
  }

  //order item list
  Widget _orderItemList(int orderIndex) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: controller.orderWithFoodItemList[orderIndex].foodList.length,
      itemBuilder: (ctx, i) => _orderProductsItem(orderIndex, i),
    );
  }

  //order item
  Widget _orderProductsItem(int orderIndex, int orderItemIndex) {
    return GestureDetector(
      onTap: () => controller.goToProductDetails(
        controller.orderWithFoodItemList[orderIndex].foodList[orderItemIndex],
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
        width: Get.width,
        child: Row(
          children: [
            _buildImage(controller.orderWithFoodItemList[orderIndex]
                    .foodList[orderItemIndex].imgUrl ??
                ""),
            SpacerWidget.w10,
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(right: 15),
                padding: const EdgeInsets.only(bottom: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.orderWithFoodItemList[orderIndex]
                              .foodList[orderItemIndex].title ??
                          "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Get.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkGrey,
                      ),
                    ),
                    Text(
                      "${controller.orderWithFoodItemList[orderIndex].foodList[orderItemIndex].price ?? ""} ${Strings.tk}",
                      style: Get.textTheme.bodyMedium?.copyWith(
                        color: AppColors.darkGrey,
                      ),
                    ),
                    Text(
                      "x${controller.orderWithFoodItemList[orderIndex].qtyList[orderItemIndex]}",
                      style: Get.textTheme.bodySmall?.copyWith(
                        color: AppColors.darkGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

//Build BuyAgain Button
  Widget _buildBuyAgainButton(int orderIndex) {
    return SizedBox(
      width: 110,
      height: 30,
      child: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: TextButton(
          style: const ButtonStyle(
            padding:
                MaterialStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.zero),
            backgroundColor: MaterialStatePropertyAll<Color>(
              AppColors.accentColor,
            ),
            shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
            ),
          ),
          onPressed: () => controller.buyAgain(
            controller.orderWithFoodItemList[orderIndex].foodList,
            controller.orderWithFoodItemList[orderIndex].qtyList,
          ),
          child: Text(
            Strings.buyAgain,
            style: Get.textTheme.bodyMedium?.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

//Build Image
  Widget _buildImage(String url) {
    return SizedBox(
      height: 60,
      width: 60,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        child: CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.fill,
          placeholder: (context, url) => _buildImgPlaceholder(),
          errorWidget: (context, url, error) => _buildImgPlaceholder(),
        ),
      ),
    );
  }

  //Build Image PlaceHolder
  Widget _buildImgPlaceholder() {
    return Icon(
      Icons.broken_image,
      size: 30,
      color: AppColors.grey.withOpacity(0.3),
    );
  }

  //user description
  Widget _userDescription() {
    return Row(
      children: [
        SpacerWidget.w20,
        const Icon(
          Icons.account_circle,
          size: 50,
          color: AppColors.grey,
        ),
        SpacerWidget.w10,
        _nameEmail(),
        SpacerWidget.w10,
        _logout(),
        SpacerWidget.w5,
      ],
    );
  }

  //logout
  Widget _logout() {
    return IconButton(
      onPressed: () => controller.logout(),
      icon: const Icon(
        Icons.logout,
        color: AppColors.darkRed,
      ),
    );
  }

  //email and name
  Widget _nameEmail() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            controller.getUserName(),
            style: Get.textTheme.bodyLarge?.copyWith(
              color: AppColors.darkGrey,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            controller.getUserEmail(),
            style: Get.textTheme.bodyMedium?.copyWith(
              color: AppColors.darkGrey,
            ),
          ),
        ],
      ),
    );
  }

  //Text Filed label text
  Widget _label(
    String label,
  ) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: label,
            style: Get.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
            children: [
              TextSpan(
                text: "(5)",
                style: Get.textTheme.bodyLarge?.copyWith(
                  color: AppColors.darkRed,
                ),
              ),
            ],
          ),
        ));
  }

  //Build Loader
  Widget _buildLoader() {
    return const SizedBox(
      height: 80,
      child: Center(
        child: SpinKitThreeInOut(
          color: AppColors.accentColor,
          size: 25,
        ),
      ),
    );
  }
}
