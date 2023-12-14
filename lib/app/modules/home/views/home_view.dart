import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:foodie/app/common/common_func.dart';
import 'package:foodie/app/common/widgets/sliver_appbar_widget.dart';
import 'package:foodie/app/config/app_colors.dart';
import 'package:foodie/app/data/models/food_model.dart';
import 'package:foodie/app/modules/home/widgets/category_section_header.dart';
import 'package:foodie/app/utils/spacer_widgets.dart';
import 'package:foodie/app/utils/strings.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  @override
  final HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pendingColor.withOpacity(0.3),
      body:
          // controller.obx(
          //   (data) =>
          _buildBody(),
      //   onLoading: _buildLoader(),
      // ),
    );
  }

  //Build Body
  Widget _buildBody() {
    return CustomScrollView(
      slivers: [
        const SliverAppBarWidget(
          titleText: Strings.appName,
          sliderImg: Strings.homeBannerUrl,
          showLeading: false,
        ),
        SliverToBoxAdapter(
          child: SpacerWidget.h10,
        ),
        SliverToBoxAdapter(
          child: Obx(
            () => controller.isLoading
                ? _buildLoader()
                : Column(
                    children: [
                      const CategorySectionHeader(label: Strings.beverages),
                      _buildProductList(controller.beveragesList),
                      const CategorySectionHeader(label: Strings.snacks),
                      _buildProductList(controller.snacksList),
                      const CategorySectionHeader(label: Strings.fastFood),
                      _buildProductList(controller.fastFoodList),
                      const CategorySectionHeader(label: Strings.meals),
                      _buildProductList(controller.mealsList),
                      const CategorySectionHeader(label: Strings.deserts),
                      _buildProductList(controller.desertsList),
                    ],
                  ),
          ),
        ),
        SliverToBoxAdapter(
          child: SpacerWidget.h40,
        ),
      ],
    );
  }

  //Build Category Product List
  Widget _buildProductList(List<FoodModel> list) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        height: 210,
        width: Get.width,
        child: Obx(
          () => ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: list.length,
            itemBuilder: (ctx, i) => _buildProduct(
              list[i],
            ),
          ),
        ),
      ),
    );
  }

// //Build Product
  Widget _buildProduct(FoodModel food) {
    return GestureDetector(
      onTap: () => controller.goToProductDetails(food),
      child: Container(
        height: 210,
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        margin: const EdgeInsets.only(right: 5, left: 10),
        child: Stack(
          children: [
            _buildImage(food.imgUrl ?? ""),
            Positioned(
              right: 3,
              top: 94,
              child: _buildWishlistIcon(food),
            ),
            Positioned(
              top: 125,
              child: Container(
                height: 80,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildRating(food.ratings ?? 1.0),
                    SizedBox(
                      width: 110,
                      child: Text(
                        food.title ?? "",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Get.textTheme.bodyMedium,
                      ),
                    ),
                    Text(
                      "${food.price} ${Strings.tk}",
                      style: Get.textTheme.bodyMedium
                          ?.copyWith(color: AppColors.accentColor),
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

//Build rating
  Widget _buildRating(double rating) {
    return RatingBar.builder(
      initialRating: rating,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: 12,
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {},
    );
  }

//Build Wishlist Icon
  Widget _buildWishlistIcon(FoodModel food) {
    return Obx(
      () => GestureDetector(
        onTap: () => setFavoriteStatus(food),
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
              size: controller.getFavoriteStatus(food) ? 25 : 20,
              color: controller.getFavoriteStatus(food)
                  ? AppColors.red
                  : AppColors.white.withOpacity(0.8),
            ),
          ),
        ),
      ),
    );
  }

//Build Image
  Widget _buildImage(String url) {
    return Container(
      height: 110,
      width: 130,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
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
}
