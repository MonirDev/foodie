import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodie/app/common/widgets/custom_app_bar.dart';
import 'package:foodie/app/common/widgets/not_available.dart';
import 'package:foodie/app/config/app_colors.dart';
import 'package:foodie/app/data/models/food_model.dart';
import 'package:foodie/app/utils/app_constants.dart';
import 'package:foodie/app/utils/spacer_widgets.dart';
import 'package:foodie/app/utils/strings.dart';

import 'package:get/get.dart';

import '../controllers/favourite_controller.dart';

class FavouriteView extends GetView<FavouriteController> {
  FavouriteView({Key? key}) : super(key: key);
  @override
  final FavouriteController controller = Get.put(FavouriteController());
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
          title: Strings.favourites,
          useBackBtn: false,
        ),
        SpacerWidget.h15,
        _itemList(),
      ],
    );
  }

  //item list
  Widget _itemList() {
    return Expanded(
      child: Obx(
        () => controller.favoriteList.isEmpty
            ? const NotAvailable()
            : ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: controller.favoriteList.length,
                itemBuilder: (ctx, i) {
                  return _item(
                    controller.favoriteList[i],
                  );
                },
              ),
      ),
    );
  }

  //item
  Widget _item(FoodModel food) {
    return GestureDetector(
      onTap: () => controller.goToProductDetails(food),
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
                _buildImage(food.imgUrl ?? ""),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(right: 15),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          food.title ?? "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Get.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkGrey,
                          ),
                        ),
                        Text(
                          "${food.price} ${Strings.tk}",
                          style: Get.textTheme.bodyMedium?.copyWith(
                            color: AppColors.accentColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            _closeBtn(food.id ?? ""),
          ],
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

  //build close button
  Widget _closeBtn(String id) {
    return Positioned(
      top: 5,
      right: 5,
      child: GestureDetector(
        onTap: () => controller.removeFoodFromList(id),
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
