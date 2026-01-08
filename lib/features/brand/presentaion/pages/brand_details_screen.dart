import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/features/brand/presentaion/getx/brand_details_controller.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/theme.dart';
import '../../../../shared/widgets/app_background.dart';
import '../../../../shared/widgets/data_loading_widget.dart';
import '../../../../shared/widgets/url_widget.dart';

class BrandDetailsScreen extends StatelessWidget {
  const BrandDetailsScreen({super.key, required this.brandID});

  final int brandID;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BrandDetailsController>(
      init: BrandDetailsController(brandID),
      builder: (controller) => Scaffold(
        appBar: AppBar(backgroundColor: AppTheme.secondaryColor, title: Text(controller.brandDetails?.name ?? "", maxLines: 1)),
        body: AppBackground(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: controller.isLoading
                ? DataLoadingWidget()
                : SingleChildScrollView(
                    controller: controller.scrollController,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [BoxShadow(color: AppTheme.primaryColor.withOpacity(.25), blurRadius: 10, blurStyle: BlurStyle.outer)],
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: AppTheme.borderRadius,
                                      child: Hero(
                                        tag: "brandImage$brandID",
                                        child: CachedNetworkImage(
                                          imageUrl: controller.brandDetails?.imageUrl ?? "",
                                          placeholder: (w, e) => Image.asset(AssetsConsts.loading, fit: BoxFit.contain),
                                          fit: BoxFit.contain,
                                          errorWidget: (c, e, s) => Image.asset(AssetsConsts.imageError),
                                          width: Get.width,
                                          height: Get.height * .24,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.brandDetails?.name ?? "",
                                      style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size16, isBold: true),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              ' ${controller.brandDetails?.description ?? ""}',
                                              style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size14),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.all(12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    if ((controller.brandDetails?.webSiteUrl ?? "").isNotEmpty)
                                      UrlWidget(image: AssetsConsts.website, url: controller.brandDetails?.webSiteUrl ?? ""),
                                    if ((controller.brandDetails?.mobileNumber ?? "").isNotEmpty)
                                      UrlWidget(
                                        image: AssetsConsts.phoneIcon,
                                        url: "tel:${AppConstants.countryCode}${controller.brandDetails?.mobileNumber}",
                                      ),
                                    if ((controller.brandDetails?.mobileNumber ?? "").isNotEmpty)
                                      UrlWidget(
                                        image: AssetsConsts.whatsApp,
                                        url: Platform.isAndroid
                                            ? "https://wa.me/${AppConstants.countryCode}${controller.brandDetails!.mobileNumber!}"
                                            : "https://api.whatsapp.com/send?phone=${AppConstants.countryCode}${controller.brandDetails!.mobileNumber!}",
                                      ),
                                    if ((controller.brandDetails?.faceBookUrl ?? "").isNotEmpty)
                                      UrlWidget(image: AssetsConsts.faceBook, url: controller.brandDetails?.faceBookUrl ?? ""),
                                    if ((controller.brandDetails?.instagramUrl ?? "").isNotEmpty)
                                      UrlWidget(image: AssetsConsts.instagram, url: controller.brandDetails?.instagramUrl ?? ""),
                                    if ((controller.brandDetails?.twitterUrl ?? "").isNotEmpty)
                                      UrlWidget(image: AssetsConsts.twitter, url: controller.brandDetails?.twitterUrl ?? ""),
                                    if ((controller.brandDetails?.tikTokUrl ?? "").isNotEmpty)
                                      UrlWidget(image: AssetsConsts.tiktok, url: controller.brandDetails?.tikTokUrl ?? ""),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Text(
                                "ourBranches".tr,
                                style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size20, isBold: true),
                              ),
                            ],
                          ),
                        ),
                        // BranchListScreen(brandId: brandID, scrollController: controller.scrollController),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
