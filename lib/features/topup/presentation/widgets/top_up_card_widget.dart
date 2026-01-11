import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/utils/theme.dart';
import '../../../../shared/helper/shared_helper.dart';
import '../../../../shared/widgets/sar_widget.dart';
import '../../domain/entities/top_up_list.dart';

class TopUpCardWidget extends StatelessWidget {
  const TopUpCardWidget({super.key, required this.topUp});

  final TopUp topUp;

  @override
  Widget build(BuildContext context) {
    final hasImage = topUp.image?.isNotEmpty ?? false;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppTheme.primaryColor.withOpacity(0.15)),
        boxShadow: [BoxShadow(color: AppTheme.primaryColor.withOpacity(0.08), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasImage)
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: CachedNetworkImage(
                imageUrl: topUp.image ?? "",
                width: 90,
                height: 90,
                fit: BoxFit.cover,
                placeholder: (w, e) => Image.asset(AssetsConsts.loading, fit: BoxFit.cover),
                errorWidget: (c, e, s) => Container(color: Colors.grey.shade200),
              ),
            ),

          if (hasImage) const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  topUp.title ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size16, isBold: true),
                ),
                const SizedBox(height: 4),
                Text(
                  topUp.description ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.textStyle(color: AppTheme.textColor.withOpacity(0.7), size: AppTheme.size12),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _infoChip(
                      "price".tr,
                      CurrencyAmountText(
                        amountText: SharedHelper.getNumberFormat(topUp.price ?? 0),
                        amountStyle: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size14, isBold: true),
                      ),
                    ),

                    // const SizedBox(width: 10),
                    // _infoChip("value".tr, "${SharedHelper.getNumberFormat(topUp.value ?? 0)} ${AppConstants.currencyCode.tr}"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoChip(String label, dynamic value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        decoration: BoxDecoration(color: AppTheme.primaryColor.withOpacity(0.06), borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: AppTheme.textStyle(color: AppTheme.primaryColor.withOpacity(0.7), size: AppTheme.size11),
            ),
            const SizedBox(height: 2),
            value is String
                ? Text(
                    value,
                    style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size14, isBold: true),
                  )
                : value,
          ],
        ),
      ),
    );
  }
}
