import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:foodie/app/common/widgets/sliver_appbar_widget.dart';
import 'package:foodie/app/config/app_colors.dart';
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
      backgroundColor: AppColors.grey.withOpacity(0.2),
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
        const CategorySectionHeader(label: Strings.beverages),
        _buildProductList(["", "", "", ""]),
        const CategorySectionHeader(label: Strings.snacks),
        _buildProductList(["", "", "", ""]),
        const CategorySectionHeader(label: Strings.fastFood),
        _buildProductList(["", "", "", ""]),
        const CategorySectionHeader(label: Strings.meals),
        _buildProductList(["", "", "", ""]),
        const CategorySectionHeader(label: Strings.desserts),
        _buildProductList(["", "", "", ""]),
        SliverToBoxAdapter(
          child: SpacerWidget.h40,
        ),
      ],
    );
  }

  //Build Category Product List
  Widget _buildProductList(List<String> list) {
    return SliverPadding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      sliver: SliverToBoxAdapter(
        child: SizedBox(
          height: 210,
          width: Get.width,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            children: list
                .asMap()
                .map(
                  (index, value) {
                    return MapEntry(
                      index,
                      _buildProduct(),
                    );
                  },
                )
                .values
                .toList(),
          ),
        ),
      ),
    );
  }

// //Build Product
  Widget _buildProduct() {
    return GestureDetector(
      onTap: () => controller.goToProductDetails(),
      child: Container(
        height: 210,
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        margin: const EdgeInsets.only(right: 10),
        child: Stack(
          children: [
            _buildImage(
                "https://images.unsplash.com/photo-1542601098-3adb3baeb1ec?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=5bb9a9747954cdd6eabe54e3688a407e&auto=format&fit=crop&w=500&q=60"),
            Positioned(
              right: 0,
              top: 94,
              child: _buildWishlistIcon(),
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
                    _buildRating(),
                    SizedBox(
                      width: 110,
                      child: Text(
                        "title title title ",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Get.textTheme.bodyMedium,
                      ),
                    ),
                    Text(
                      " 0 Tk",
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
  Widget _buildRating() {
    return RatingBar.builder(
      initialRating: 3.5,
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
  Widget _buildWishlistIcon() {
    return Container(
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
    return const Center(
      child: SpinKitThreeInOut(
        color: AppColors.grey,
        size: 25,
      ),
    );
  }
}
