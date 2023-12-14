import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodie/app/common/widgets/custom_app_bar.dart';
import 'package:foodie/app/config/app_colors.dart';
import 'package:foodie/app/utils/spacer_widgets.dart';
import 'package:foodie/app/utils/strings.dart';

import 'package:get/get.dart';

import '../controllers/order_controller.dart';

class OrderView extends GetView<OrderController> {
  OrderView({Key? key}) : super(key: key);
  @override
  final OrderController controller = Get.put(OrderController());
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
          title: Strings.placeOrder,
          useBackBtn: true,
        ),
        Expanded(
          child: Obx(
            () => SingleChildScrollView(
              child: Column(
                children: [
                  SpacerWidget.h10,
                  _orderItemList(),
                  SpacerWidget.h15,
                  _orderInformation(),
                  SpacerWidget.h30,
                  _buildPlaceOrderButton(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  //order information
  Widget _orderInformation() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _label("${Strings.totalItem}: "),
            _label("${Strings.totalAmount}: "),
            _label("${Strings.deliveryType}: "),
          ],
        ),
        SpacerWidget.w40,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _value(controller.totalItem()),
            _value(controller.getTotalPriceOfCart().toString(), Strings.tk),
            _value("", Strings.cashOnDelivery),
          ],
        ),
      ],
    );
  }

  //order item list
  Widget _orderItemList() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: controller.cartFoodList.length,
      itemBuilder: (ctx, i) => _orderProductsItem(i),
    );
  }

  //order item
  Widget _orderProductsItem(int i) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 10,
        left: 20,
        right: 20,
      ),
      width: Get.width,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImage(controller.cartFoodList[i].imgUrl ?? ""),
                SpacerWidget.w10,
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                controller.cartFoodList[i].title ?? "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Get.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.darkGrey),
                              ),
                            ),
                            SpacerWidget.w5,
                            Text(
                              "${controller.cartFoodList[i].price ?? ""} ${Strings.tk}",
                              style: Get.textTheme.bodySmall?.copyWith(
                                color: AppColors.darkGrey,
                              ),
                            ),
                            SpacerWidget.w5,
                          ],
                        ),
                        SpacerWidget.h5,
                        _increaseDecreaseSection(i),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          _closeBtn(i),
        ],
      ),
    );
  }

  //build close button
  Widget _closeBtn(int i) {
    return Positioned(
      top: 0,
      right: 5,
      child: GestureDetector(
        onTap: () => controller.removeFoodItem(i),
        child: Container(
          height: 17,
          width: 17,
          decoration: BoxDecoration(
            color: AppColors.black.withOpacity(0.05),
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: const Center(
            child: Icon(
              Icons.close,
              size: 13,
              color: AppColors.darkRed,
            ),
          ),
        ),
      ),
    );
  }

  //build increase, decrease section
  Widget _increaseDecreaseSection(int i) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              SpacerWidget.w20,
              GestureDetector(
                onTap: () => controller.decrease(i),
                child: const Icon(
                  Icons.remove,
                  size: 18,
                  color: AppColors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: Obx(() => Text(
                      controller.cartFoodQty[i],
                      style: Get.textTheme.bodyMedium?.copyWith(
                        color: AppColors.accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ),
              GestureDetector(
                onTap: () => controller.increase(i),
                child: const Icon(
                  Icons.add,
                  size: 18,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
        ),
        Text(
          "${controller.getQtyPrice(
            controller.cartFoodList[i].price ?? 0.0,
            controller.cartFoodQty[i],
          )} ${Strings.tk}",
          style: Get.textTheme.bodySmall?.copyWith(
            color: AppColors.accentColor,
          ),
        ),
        SpacerWidget.w5,
      ],
    );
  }

//total
  Widget _label(String value) {
    return Text(
      value,
      style: Get.textTheme.bodyMedium?.copyWith(
        color: AppColors.darkGrey,
      ),
    );
  }

//Build PlaceOrder Button
  Widget _buildPlaceOrderButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
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
        onPressed: () => controller.placeOrder(),
        child: Text(
          Strings.placeOrder,
          style: Get.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }

  //value
  Widget _value(String value, [String? tk]) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: "$value ",
            style: Get.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.accentColor,
            ),
          ),
          TextSpan(
            text: tk,
            style: Get.textTheme.bodyMedium?.copyWith(
              color: AppColors.darkGrey,
            ),
          ),
        ],
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
}
