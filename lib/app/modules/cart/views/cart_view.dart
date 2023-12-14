import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:foodie/app/common/widgets/custom_app_bar.dart';
import 'package:foodie/app/common/widgets/not_available.dart';
import 'package:foodie/app/config/app_colors.dart';
import 'package:foodie/app/data/models/food_model.dart';
import 'package:foodie/app/utils/app_constants.dart';
import 'package:foodie/app/utils/spacer_widgets.dart';
import 'package:foodie/app/utils/strings.dart';

import 'package:get/get.dart';

import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  CartView({Key? key}) : super(key: key);
  @override
  final CartController controller = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  //Build Body
  Widget _buildBody() {
    return Column(
      children: [
        const CustomAppbar(
          title: Strings.myCart,
          useBackBtn: false,
        ),
        SpacerWidget.h15,
        _content(),
      ],
    );
  }

  //body content
  Widget _content() {
    return Expanded(
      child: Obx(
        () => controller.isLoading
            ? _buildLoader()
            : controller.cartFoodList.isEmpty
                ? const NotAvailable()
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        _itemList(
                          controller.cartFoodList,
                        ),
                        SpacerWidget.h10,
                        _totalAmount(),
                        SpacerWidget.h20,
                        _buildCheckoutButton(),
                      ],
                    ),
                  ),
      ),
    );
  }

  //item list
  Widget _itemList(List<FoodModel> list) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: list
            .asMap()
            .map(
              (index, value) {
                return MapEntry(
                  index,
                  _item(index),
                );
              },
            )
            .values
            .toList(),
      ),
    );
  }

  //item
  Widget _item(int index) {
    return GestureDetector(
      onTap: () =>
          controller.goToProductDetails(controller.cartFoodList[index]),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 90,
        width: Get.width,
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          boxShadow: [
            Constants.boxShadow,
          ],
        ),
        child: Stack(
          children: [
            Row(
              children: [
                _buildImage(controller.cartFoodList[index].imgUrl ?? ""),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(right: 20),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                controller.cartFoodList[index].title ?? "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Get.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.darkGrey),
                              ),
                            ),
                            SpacerWidget.w5,
                            Text(
                              "${controller.cartFoodList[index].price ?? ""} ${Strings.tk}",
                              style: Get.textTheme.bodySmall?.copyWith(
                                color: AppColors.darkGrey,
                              ),
                            ),
                          ],
                        ),
                        _increaseDecreaseSection(index),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            _closeBtn(index),
          ],
        ),
      ),
    );
  }

  //build increase, decrease section
  Widget _increaseDecreaseSection(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              SpacerWidget.w20,
              GestureDetector(
                onTap: () => controller.decrease(
                  index,
                ),
                child: const Icon(
                  Icons.remove,
                  size: 20,
                  color: AppColors.black,
                ),
              ),
              Obx(() => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    child: Text(
                      controller.cartFoodQty[index],
                      style: Get.textTheme.bodyLarge?.copyWith(
                        color: AppColors.accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
              GestureDetector(
                onTap: () => controller.increase(
                  index,
                ),
                child: const Icon(
                  Icons.add,
                  size: 20,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
        ),
        Text(
          "${controller.getQtyPrice(
            controller.cartFoodList[index].price ?? 0.0,
            controller.cartFoodQty[index],
          )} ${Strings.tk}",
          style: Get.textTheme.bodySmall?.copyWith(
            color: AppColors.accentColor,
          ),
        ),
      ],
    );
  }

//Build Checkout Button
  Widget _buildCheckoutButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: Get.width,
      height: 50,
      child: TextButton(
        style: const ButtonStyle(
          backgroundColor:
              MaterialStatePropertyAll<Color>(AppColors.accentColor),
          shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ),
        onPressed: () => controller.checkOut(),
        child: Text(
          Strings.checkout,
          style: Get.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }

//Build Image
  Widget _buildImage(String url) {
    return SizedBox(
      height: Get.height,
      width: 110,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
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
      size: 60,
      color: AppColors.grey.withOpacity(0.3),
    );
  }

//total
  Widget _totalAmount() {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Obx(() => RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: Get.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  const TextSpan(text: "${Strings.totalAmount}: "),
                  TextSpan(
                    text: "${controller.getTotalPriceOfCart()} ",
                    style: Get.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.accentColor,
                    ),
                  ),
                  TextSpan(
                    text: Strings.tk,
                    style: Get.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  //Build Loader
  Widget _buildLoader() {
    return SizedBox(
      height: Get.height / 2,
      child: const Center(
        child: SpinKitThreeInOut(
          color: AppColors.accentColor,
          size: 25,
        ),
      ),
    );
  }

  //build close button
  Widget _closeBtn(int index) {
    return Positioned(
      top: 5,
      right: 5,
      child: GestureDetector(
        onTap: () => controller.removeFoodItem(index),
        child: Container(
          height: 22,
          width: 22,
          decoration: BoxDecoration(
            color: AppColors.black.withOpacity(0.05),
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: const Center(
            child: Icon(
              Icons.close,
              size: 15,
              color: AppColors.darkRed,
            ),
          ),
        ),
      ),
    );
  }
}
