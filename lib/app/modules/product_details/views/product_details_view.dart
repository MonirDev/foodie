import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:foodie/app/config/app_colors.dart';
import 'package:foodie/app/data/models/food_model.dart';
import 'package:foodie/app/utils/spacer_widgets.dart';
import 'package:foodie/app/utils/strings.dart';

import 'package:get/get.dart';

import '../controllers/product_details_controller.dart';

class ProductDetailsView extends GetView<ProductDetailsController> {
  const ProductDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Obx(
              () => _buildBody(),
            ),
            _buildOrderNowButton(),
          ],
        ),
      ),
    );
  }

  //Build Body
  Widget _buildBody() {
    return CustomScrollView(
      slivers: [
        _buildImage(),
        _buildTitleHeader(),
        _buildProductDetails(),
      ],
    );
  }

//Build Title header
  Widget _buildTitleHeader() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildLabel(),
            SpacerWidget.w10,
            _buildPrice(),
          ],
        ),
      ),
    );
  }

//Build Product details
  Widget _buildProductDetails() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRating(),
            SpacerWidget.h10,
            _buildDescription(),
            _buildDescriptionText(),
          ],
        ),
      ),
    );
  }

//Build OrderNow Button
  Widget _buildOrderNowButton() {
    return Positioned(
      bottom: 20,
      child: SizedBox(
        width: 150,
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
          onPressed: () => controller.buyNow(),
          child: Text(
            Strings.buyNow,
            style: Get.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }

//Build Description
  Widget _buildDescription() {
    return Text(
      Strings.description,
      overflow: TextOverflow.ellipsis,
      style: Get.textTheme.bodyLarge,
    );
  }

//Build DescriptionText
  Widget _buildDescriptionText() {
    return Text(
      controller.foodModel.description ?? "",
      style: Get.textTheme.bodyMedium?.copyWith(
        color: AppColors.mediumGrey,
      ),
    );
  }

//Build Label
  Widget _buildLabel() {
    return Expanded(
      child: Text(
        controller.foodModel.title ?? "",
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: Get.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  //Build Price
  Widget _buildPrice() {
    return SizedBox(
      width: 60,
      child: Text(
        "${controller.foodModel.price} ${Strings.tk}",
        style: Get.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

//Build rating
  Widget _buildRating() {
    return RatingBar.builder(
      initialRating: controller.foodModel.ratings ?? 1.0,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: 15,
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {},
    );
  }

//Build Image
  Widget _buildImage() {
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          SizedBox(
            width: Get.width,
            height: 210,
            child: CachedNetworkImage(
              imageUrl: controller.foodModel.imgUrl ?? "",
              fit: BoxFit.fill,
              placeholder: (context, url) => _buildImgPlaceholder(),
              errorWidget: (context, url, error) => _buildImgPlaceholder(),
            ),
          ),
          _buildWishlistIcon(controller.foodModel),
          _buildAddCartIcon(),
          _backBtn(),
        ],
      ),
    );
  }

  //build back button
  Widget _backBtn() {
    return Positioned(
        left: 0,
        child: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.red,
          ),
        ));
  }

//Build Wishlist Icon
  Widget _buildWishlistIcon(FoodModel food) {
    return Positioned(
      top: 20,
      right: 20,
      child: Obx(
        () => GestureDetector(
          onTap: () => controller.updateFavStatusInHomeAndFavoritePage(food),
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              color: controller.getFavoriteStatus(food)
                  ? AppColors.grey.withOpacity(0.3)
                  : AppColors.grey,
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Center(
              child: Icon(
                Icons.favorite,
                size: 20,
                color: controller.getFavoriteStatus(food)
                    ? AppColors.red
                    : AppColors.white.withOpacity(0.8),
              ),
            ),
          ),
        ),
      ),
    );
  }

//Build AddCart Icon
  Widget _buildAddCartIcon() {
    return Positioned(
      bottom: 20,
      right: 20,
      child: GestureDetector(
        onTap: () => controller.addToCart(controller.foodModel),
        child: Container(
          height: 40,
          width: 40,
          decoration: const BoxDecoration(
            color: AppColors.pendingColor,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: const Center(
            child: Icon(
              Icons.add_shopping_cart,
              size: 25,
              color: AppColors.red,
            ),
          ),
        ),
      ),
    );
  }

//Build Image PlaceHolder
  Widget _buildImgPlaceholder() {
    return Icon(
      Icons.broken_image,
      size: Get.width * 0.25,
      color: AppColors.grey.withOpacity(0.3),
    );
  }
}
