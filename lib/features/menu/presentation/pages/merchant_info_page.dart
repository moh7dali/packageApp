import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/theme.dart';
import '../../../../shared/getx/merchant_info_controller.dart';
import '../../../../shared/widgets/url_widget.dart';

class MerchantInfoPage extends StatelessWidget {
  const MerchantInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MerchantInfoController>(
      init: MerchantInfoController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(title: Text("connectWithUs".tr)),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(gradient: AppTheme.gradient1, borderRadius: AppTheme.bigBorderRadius),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        controller.isLoading
                            ? Center(child: CircularProgressIndicator(color: AppTheme.whiteColor))
                            : Column(
                                children: [
                                  if (!((controller.merchantInfo?.faceBookUrl ?? "").isEmpty &&
                                      (controller.merchantInfo?.instagramUrl ?? "").isEmpty &&
                                      (controller.merchantInfo?.twitterUrl ?? "").isEmpty))
                                    Text(
                                      'connectWithUsOnSocialMedia'.tr,
                                      style: AppTheme.textStyle(color: AppTheme.whiteColor, size: AppTheme.size16, isBold: true),
                                    ),
                                  SizedBox(height: Get.height * .04),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if ((controller.merchantInfo?.faceBookUrl ?? "").isNotEmpty)
                                        UrlWidget(image: AssetsConsts.faceBook, url: controller.merchantInfo?.faceBookUrl ?? ""),
                                      if ((controller.merchantInfo?.instagramUrl ?? "").isNotEmpty)
                                        UrlWidget(image: AssetsConsts.instagram, url: controller.merchantInfo?.instagramUrl ?? ""),
                                      if ((controller.merchantInfo?.twitterUrl ?? "").isNotEmpty)
                                        UrlWidget(image: AssetsConsts.twitter, url: controller.merchantInfo?.twitterUrl ?? ""),
                                    ],
                                  ),
                                  if (!((controller.merchantInfo?.faceBookUrl ?? "").isEmpty &&
                                      (controller.merchantInfo?.instagramUrl ?? "").isEmpty &&
                                      (controller.merchantInfo?.twitterUrl ?? "").isEmpty))
                                    Column(
                                      children: [
                                        SizedBox(height: Get.height * .04),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                                          child: Divider(color: AppTheme.whiteColor, height: Get.height * .02, thickness: 3),
                                        ),
                                        SizedBox(height: Get.height * .04),
                                      ],
                                    ),
                                  if (!((controller.merchantInfo?.mobile ?? "").isEmpty && (controller.merchantInfo?.phone ?? "").isEmpty))
                                    Text(
                                      'contactUs'.tr.toUpperCase(),
                                      style: AppTheme.textStyle(color: AppTheme.whiteColor, size: AppTheme.size16, isBold: true),
                                    ),
                                  SizedBox(height: Get.height * .04),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      if ((controller.merchantInfo?.phone ?? "").isNotEmpty)
                                        UrlWidget(
                                          image: AssetsConsts.whatsApp,
                                          url: Platform.isAndroid
                                              ? "https://wa.me/${AppConstants.countryCode}${controller.merchantInfo!.phone!}"
                                              : "https://api.whatsapp.com/send?phone=${AppConstants.countryCode}${controller.merchantInfo!.phone!}",
                                        ),
                                      if ((controller.merchantInfo?.mobile ?? "").isNotEmpty)
                                        UrlWidget(
                                          image: AssetsConsts.phoneIcon,
                                          url: "tel:${AppConstants.countryCode}${controller.merchantInfo!.mobile!}",
                                        ),
                                    ],
                                  ),
                                  if ((controller.merchantInfo?.webSiteUrl ?? "").isNotEmpty)
                                    Column(
                                      children: [
                                        SizedBox(height: Get.height * .04),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                                          child: Divider(color: AppTheme.whiteColor, height: Get.height * .02, thickness: 3),
                                        ),
                                        SizedBox(height: Get.height * .04),
                                        Text(
                                          'visitOurWebsite'.tr,
                                          style: AppTheme.textStyle(color: AppTheme.whiteColor, size: AppTheme.size16, isBold: true),
                                        ),
                                        SizedBox(height: Get.height * .04),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [UrlWidget(image: AssetsConsts.website, url: controller.merchantInfo?.webSiteUrl ?? "")],
                                        ),
                                        SizedBox(height: Get.height * .02),
                                      ],
                                    ),
                                ],
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
