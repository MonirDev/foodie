import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:foodie/app/config/app_colors.dart';
import 'package:get/get.dart';

class SliverAppBarWidget extends StatelessWidget {
  final String titleText;
  final String sliderImg;
  final bool showLeading;
  const SliverAppBarWidget(
      {super.key,
      required this.titleText,
      required this.showLeading,
      required this.sliderImg});

  @override
  Widget build(BuildContext context) {
    return SliverLayoutBuilder(
      builder: (context, constraints) => SliverAppBar(
        automaticallyImplyLeading: false,
        expandedHeight: 180,
        pinned: true,
        primary: true,
        flexibleSpace: _buildSLiderImageWithtitle(constraints),
        leading: showLeading ? _buildleading() : const SizedBox(),
        centerTitle: true,
        backgroundColor: AppColors.accentColor,
      ),
    );
  }

//Build Slider Image with title
  FlexibleSpaceBar _buildSLiderImageWithtitle(SliverConstraints constraints) {
    return FlexibleSpaceBar(
      titlePadding: const EdgeInsets.only(bottom: 13),
      background: CachedNetworkImage(
        imageUrl: sliderImg,
        fit: BoxFit.cover,
        placeholder: (context, url) => _buildImgPlaceholder(),
        errorWidget: (context, url, error) => _buildImgPlaceholder(),
      ),
      title: Text(
        constraints.scrollOffset > 130 ? titleText : "",
        style: Get.textTheme.headlineMedium?.copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
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

  //Build Leading
  Widget _buildleading() {
    return GestureDetector(
      onTap: () => Get.back(),
      child: const Icon(
        Icons.arrow_back_ios,
        size: 20,
        color: AppColors.white,
      ),
    );
  }
}
