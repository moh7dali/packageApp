import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/shared/helper/shared_helper.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/utils/theme.dart';
import '../../domain/entity/offer.dart';

class OfferWidget extends StatelessWidget {
  const OfferWidget({super.key, required this.offer});

  final Offer offer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        SharedHelper().actionDialog(
          "${offer.title}",
          "${offer.description}",
          hasImage: offer.imageUrl != null,
          image: "${offer.imageUrl}",
          noCancel: true,
          confirmText: "close".tr,
          confirm: () {
            SharedHelper().closeAllDialogs();
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: AppTheme.borderRadius,
          color: AppTheme.whiteColor,
          border: Border.all(color: AppTheme.primaryColor, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: IntrinsicHeight(
            // Added to make children same height
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch, // Added
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(AppTheme.borderRadius.bottomLeft),
                  child: CachedNetworkImage(
                    imageUrl: offer.imageUrl ?? "",
                    placeholder: (context, url) => Image.asset(AssetsConsts.loading, fit: BoxFit.cover),
                    errorWidget: (context, url, error) => Image.asset(AssetsConsts.imageError),
                    fit: BoxFit.cover,
                    width: Get.width * 0.3,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Added
                      children: [
                        Text(
                          offer.title ?? "",
                          maxLines: 1,
                          style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size14, isBold: true),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppTheme.secondaryColor,
                              borderRadius: AppTheme.borderRadius,
                              border: Border.all(color: AppTheme.secondaryColor, width: 2),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0), // Increased padding
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Added
                                crossAxisAlignment: CrossAxisAlignment.start, // Added
                                children: [
                                  Text(
                                    offer.description ?? "",
                                    maxLines: 2,
                                    style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size12),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      "${'validUntil'.tr} ${SharedHelper.dateFormatToString(offer.endDate ?? DateTime.now())}",
                                      style: AppTheme.textStyle(color: AppTheme.textColor.withOpacity(.5), size: AppTheme.size10),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

