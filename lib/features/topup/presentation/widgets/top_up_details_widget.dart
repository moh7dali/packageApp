import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/shared/widgets/button_widget.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/utils/theme.dart';
import '../../../../shared/helper/shared_helper.dart';
import '../../../../shared/widgets/sar_widget.dart';
import '../../domain/entities/top_up_list.dart';
import '../getx/top_up_list_controller.dart';

class TopUpDetailsSheet extends StatelessWidget {
  const TopUpDetailsSheet({super.key, required this.topUp});

  final TopUp topUp;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TopUpListController>(
      tag: "TopUpDetails${topUp.id}",
      init: TopUpListController(),
      builder: (controller) {
        final price = (topUp.price ?? 0);
        final total = price * controller.quantity;
        return Container(
          decoration: BoxDecoration(
            color: AppTheme.bgColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.10), blurRadius: 18, offset: const Offset(0, -6))],
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 16 + MediaQuery.of(context).padding.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 44,
                  height: 5,
                  decoration: BoxDecoration(color: AppTheme.primaryColor.withOpacity(0.18), borderRadius: BorderRadius.circular(10)),
                ),
                const SizedBox(height: 14),
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (topUp.image?.isNotEmpty ?? false)
                              ClipRRect(
                                borderRadius: AppTheme.bigBorderRadius,
                                child: CachedNetworkImage(
                                  imageUrl: topUp.image ?? "",
                                  width: 92,
                                  height: 92,
                                  fit: BoxFit.cover,
                                  placeholder: (w, e) => Image.asset(AssetsConsts.loading, fit: BoxFit.cover, width: 92, height: 92),
                                  errorWidget: (c, e, s) => Container(width: 92, height: 92, color: Colors.grey.shade200),
                                ),
                              ),
                            if (topUp.image?.isNotEmpty ?? false) const SizedBox(width: 12),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    topUp.title ?? "",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size18, isBold: true),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    topUp.description ?? "",
                                    style: AppTheme.textStyle(color: AppTheme.textColor.withOpacity(0.75), size: AppTheme.size12),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 14),
                        Row(
                          children: [
                            Expanded(
                              child: _infoChip(
                                "price".tr,
                                CurrencyAmountText(
                                  amountText: SharedHelper.getNumberFormat(topUp.price ?? 0),
                                  amountStyle: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size14, isBold: true),
                                ),
                              ),
                            ),

                            // const SizedBox(width: 10),
                            // Expanded(
                            //   child: _infoChip("value".tr, "${SharedHelper.getNumberFormat(topUp.value ?? 0)} ${AppConstants.currencyCode.tr}"),
                            // ),
                          ],
                        ),

                        const SizedBox(height: 14),

                        // quantity row (premium stepper)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor.withOpacity(0.06),
                            borderRadius: AppTheme.bigBorderRadius,
                            border: Border.all(color: AppTheme.primaryColor.withOpacity(0.10)),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "quantity".tr,
                                  style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size14, isBold: true),
                                ),
                              ),
                              _qtyBtn(icon: Icons.remove_rounded, onTap: controller.decrease),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 14),
                                child: Text(
                                  "${controller.quantity}",
                                  style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size16, isBold: true),
                                ),
                              ),
                              _qtyBtn(icon: Icons.add_rounded, onTap: controller.increase),
                            ],
                          ),
                        ),

                        const SizedBox(height: 18),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withOpacity(0.06),
                          borderRadius: AppTheme.bigBorderRadius,
                          border: Border.all(color: AppTheme.primaryColor.withOpacity(0.10)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "totalPrice".tr,
                              style: AppTheme.textStyle(color: AppTheme.primaryColor.withOpacity(0.75), size: AppTheme.size11),
                            ),
                            const SizedBox(height: 2),
                            CurrencyAmountText(
                              amountText: SharedHelper.getNumberFormat(total),
                              amountStyle: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size16, isBold: true),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: SizedBox(
                        height: 52,
                        child: AppButton(
                          title: "payNow".tr,
                          function: () => controller.pay(topUp: topUp),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _infoChip(String label, dynamic value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppTheme.bigBorderRadius,
        border: Border.all(color: AppTheme.primaryColor.withOpacity(0.10)),
        boxShadow: [BoxShadow(color: AppTheme.primaryColor.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTheme.textStyle(color: AppTheme.primaryColor.withOpacity(0.7), size: AppTheme.size11),
          ),
          const SizedBox(height: 4),
          value is String
              ? Text(
                  value,
                  style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size14, isBold: true),
                )
              : value,
        ],
      ),
    );
  }

  Widget _qtyBtn({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.primaryColor.withOpacity(0.12)),
          boxShadow: [BoxShadow(color: AppTheme.primaryColor.withOpacity(0.06), blurRadius: 8, offset: const Offset(0, 3))],
        ),
        child: Icon(icon, color: AppTheme.primaryColor, size: 18),
      ),
    );
  }
}
