import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:foodie/app/config/app_colors.dart';
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
        backgroundColor: AppColors.white.withOpacity(0.9),
        body: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            _buildBody(),
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
          onPressed: () {},
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
      "These categories could cover a wide range of food types and preferences, allowing users to explore various options within your app, whether they're looking for a quick bite, specific cuisines, or different types of beverages and treats.",
      style: Get.textTheme.bodyMedium?.copyWith(
        color: AppColors.mediumGrey,
      ),
    );
  }

//Build Label
  Widget _buildLabel() {
    return Expanded(
      child: Text(
        "Title",
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
        "250 ${Strings.tk}",
        style: Get.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

//Build rating
  Widget _buildRating() {
    return RatingBar.builder(
      initialRating: 3.5,
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
              imageUrl:
                  "https://images.unsplash.com/photo-1542601098-3adb3baeb1ec?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=5bb9a9747954cdd6eabe54e3688a407e&auto=format&fit=crop&w=500&q=60",
              fit: BoxFit.cover,
              placeholder: (context, url) => _buildImgPlaceholder(),
              errorWidget: (context, url, error) => _buildImgPlaceholder(),
            ),
          ),
          _buildWishlistIcon(),
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
            color: AppColors.white,
          ),
        ));
  }

//Build Wishlist Icon
  Widget _buildWishlistIcon() {
    return Positioned(
      top: 20,
      right: 20,
      child: Container(
        height: 30,
        width: 30,
        decoration: const BoxDecoration(
          color: AppColors.grey,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Center(
          child: Icon(
            Icons.favorite,
            size: 20,
            color: AppColors.white.withOpacity(0.8),
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
      child: Container(
        height: 35,
        width: 35,
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

  //Build Loader
  Widget _buildLoader() {
    return Center(
      child: SpinKitThreeInOut(
        color: AppColors.grey,
        size: 25,
      ),
    );
  }
}
