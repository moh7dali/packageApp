import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linkwell/linkwell.dart';
import 'package:my_custom_widget/core/constants/assets_constants.dart';
import 'package:my_custom_widget/features/rewards_gallery/domain/entity/reward_gallery.dart';
import 'package:my_custom_widget/shared/helper/shared_helper.dart';
import 'package:my_custom_widget/shared/widgets/button_widget.dart';

import '../../../../core/sdk/sdk_rouutes.dart';
import '../../../../core/utils/theme.dart';
import '../../../../my_custom_widget.dart';
import '../getx/rewards_gallery_controller.dart';

class RewardsGalleryWidget extends StatelessWidget {
  const RewardsGalleryWidget({
    super.key,
    required this.rewardsGallery,
  });

  final RewardsGallery rewardsGallery;

  @override
  Widget build(BuildContext context) {
    final imageUrls = rewardsGallery.imageUrl ?? [];

    return GetBuilder<RewardsGalleryController>(
        init: RewardsGalleryController(),
        tag: "RewardsGalleryCard${rewardsGallery.id}",
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImageSlider(imageUrls),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitleAndPoints(),
                    const SizedBox(height: 10),
                    LinkWell(
                      rewardsGallery.description ?? "",
                      style: AppTheme.textStyle(
                        color: AppTheme.textColor.withOpacity(.75),
                        size: AppTheme.size12,
                      ),
                      linkStyle: AppTheme.textStyle(
                        color: Colors.blue,
                        size: AppTheme.size12,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildQuantitySection(controller),
                    const SizedBox(height: 10),
                    AppButton(
                      title: "redeemGift".tr,
                      function: () {
                        SharedHelper().actionDialog(
                          'redeemGift'.tr,
                          '${'redeemMultiConfirm'.tr} ${controller.quantity} ${rewardsGallery.title} ${'for'.tr} ${controller.quantity * (rewardsGallery.numberOfPoints ?? 0)} ${'points'.tr} ${appLanguage == 'en' ? '?' : '؟'}',
                          confirm: () {
                            if ((controller.quantity * (rewardsGallery.numberOfPoints ?? 0)) >
                                (controller.userLoyaltyData?.loyaltyData?.pointsBalance ?? 0)) {
                              SDKNav.back();
                              SharedHelper().errorSnackBar("youDoNotHaveBalance".tr);
                            } else {
                              controller.redeemRewardsApi(rewardId: rewardsGallery.id);
                            }
                          },
                          cancel: SharedHelper().closeAllDialogs,
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              )
            ],
          );
        });
  }

  Widget _buildImageSlider(List<String> imageUrls) {
    final imageHeight = Get.height * 0.3;

    if (imageUrls.isEmpty) {
      return SizedBox(
        height: imageHeight,
        child: Image.asset(AssetsConsts.imageErrorLong, fit: BoxFit.fill, width: Get.width),
      );
    }

    if (imageUrls.length == 1) {
      return _buildCachedImage(imageUrls.first);
    }

    return CarouselSlider(
      items: imageUrls.map((url) => _buildCachedImage(url)).toList(),
      options: CarouselOptions(
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 4),
        autoPlayAnimationDuration: const Duration(milliseconds: 300),
        height: imageHeight,
        enlargeCenterPage: true,
        aspectRatio: 0.2,
      ),
    );
  }

  Widget _buildCachedImage(String url) {
    return ClipRRect(
      borderRadius: AppTheme.borderRadius,
      child: CachedNetworkImage(
        imageUrl: url.trim(),
        fit: BoxFit.cover,
        width: Get.width,
        height: Get.height * 0.3,
        placeholder: (_, __) => Image.asset(
          AssetsConsts.loading,
          fit: BoxFit.cover,
          height: Get.height * 0.3,
          width: Get.height * 0.2,
        ),
        errorWidget: (_, __, ___) => Image.asset(
          AssetsConsts.imageErrorLong,
          width: Get.width,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _buildTitleAndPoints() {
    return Row(
      children: [
        Expanded(
          child: Text(
            rewardsGallery.title ?? "",
            style: AppTheme.textStyle(
              color: AppTheme.textColor,
              size: AppTheme.size16,
              isBold: true,
            ),
          ),
        ),
        Row(
          children: [
            Text(
              SharedHelper.getNumberFormat(rewardsGallery.numberOfPoints ?? 0),
              style: AppTheme.textStyle(
                color: AppTheme.textColor,
                size: AppTheme.size16,
                isBold: true,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              'points'.tr,
              style: AppTheme.textStyle(
                color: AppTheme.textColor,
                size: AppTheme.size14,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuantitySection(final RewardsGalleryController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("quantity".tr, style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14)),
          Container(
            height: Get.width * .085,
            width: Get.width * .4,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), border: Border.all(color: AppTheme.textColor, width: 1)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTapDown: (details) {
                    controller.startPositionAdd = false;
                    controller.startPositionSub = true;
                    controller.update();
                  },
                  onTapUp: (details) {
                    controller.quantitySub();
                  },
                  onTapCancel: () {
                    controller.quantitySub();
                  },
                  child: Icon(Icons.remove, color: AppTheme.textColor),
                ),
                Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: AppTheme.bgThemeColor, shape: BoxShape.circle),
                    child: Text(controller.quantity.toString(),
                        textAlign: TextAlign.center, style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14))),
                GestureDetector(
                  onTapDown: (details) {
                    controller.startPositionAdd = true;
                    controller.startPositionSub = false;
                    controller.update();
                  },
                  onTapUp: (details) {
                    controller.quantityAdd();
                  },
                  onTapCancel: () {
                    controller.quantityAdd();
                  },
                  child: Icon(Icons.add, color: AppTheme.textColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
