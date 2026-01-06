import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/theme.dart';
import '../../../../shared/helper/shared_helper.dart';
import '../../domain/entities/branch_details.dart';

class BranchWidget extends StatelessWidget {
  const BranchWidget({super.key, required this.value});

  final BranchDetails value;

  @override
  Widget build(BuildContext context) {
    final img = (value.branchImages ?? []).isNotEmpty ? (value.branchImages ?? []).first.imageUrl ?? "" : "";

    final hasTime = value.openTime != null && value.closeTime != null;
    final hasPhone = (value.mobile ?? "").trim().isNotEmpty;

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.whiteColor,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: AppTheme.primaryColor.withOpacity(0.10)),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 20, offset: const Offset(0, 10))],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            // IMAGE HEADER (title فقط)
            Stack(
              children: [
                SizedBox(
                  height: Get.height * 0.22,
                  width: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl: img,
                    fit: BoxFit.cover,
                    placeholder: (w, e) => Image.asset(AssetsConsts.loading, fit: BoxFit.cover),
                    errorWidget: (c, e, s) => Image.asset(AssetsConsts.imageErrorLong, fit: BoxFit.cover),
                  ),
                ),

                // overlay خفيف
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black.withOpacity(0.05), Colors.black.withOpacity(0.45)],
                      ),
                    ),
                  ),
                ),

                // Branch name
                Positioned(
                  left: 14,
                  right: 14,
                  bottom: 14,
                  child: Text(
                    value.name ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.textStyle(color: AppTheme.whiteColor, size: AppTheme.size18, isBold: true),
                  ),
                ),
              ],
            ),

            // BODY
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Open / Close time (moved here)
                  if (hasTime)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppTheme.primaryColor.withOpacity(0.12)),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(AssetsConsts.branchClockIcon, height: 18, color: AppTheme.primaryColor),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              '${SharedHelper().formatDuration(time: value.openTime)}'
                              ' - '
                              '${SharedHelper().formatDuration(time: value.closeTime)}',
                              style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14, isBold: true),
                            ),
                          ),
                        ],
                      ),
                    ),

                  if (hasTime) const SizedBox(height: 12),

                  if ((value.address ?? "").trim().isNotEmpty)
                    GestureDetector(
                      onTap: () async {
                        final url = 'https://www.google.com/maps/search/?api=1&query=${value.latitude},${value.longitude}';
                        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: AppTheme.secondaryColor.withOpacity(.5), borderRadius: BorderRadius.circular(16)),
                        child: Row(
                          children: [
                            SvgPicture.asset(AssetsConsts.branchLocationIcon, height: 18, color: AppTheme.primaryColor),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                value.address ?? "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size12),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Icon(Icons.open_in_new_rounded, size: 16, color: AppTheme.primaryColor),
                          ],
                        ),
                      ),
                    ),

                  const SizedBox(height: 14),

                  if (hasPhone)
                    GestureDetector(
                      onTap: () async {
                        await launchUrl(Uri.parse("tel:${AppConstants.countryCode}${value.mobile}"), mode: LaunchMode.externalApplication);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          gradient: AppTheme.gradient1,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [BoxShadow(color: AppTheme.primaryColor.withOpacity(0.05), blurRadius: 5, offset: const Offset(0, 8))],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.call_rounded, color: Colors.white, size: 18),
                            const SizedBox(width: 8),
                            Text(
                              "${AppConstants.countryCode}${value.mobile}",
                              style: AppTheme.textStyle(color: AppTheme.whiteColor, size: AppTheme.size14, isBold: true),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
