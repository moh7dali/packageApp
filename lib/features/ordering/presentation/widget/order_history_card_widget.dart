import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/core/constants/constants.dart';
import 'package:my_custom_widget/core/utils/theme.dart';
import 'package:my_custom_widget/shared/helper/shared_helper.dart';

import '../../../../core/sdk/sdk_rouutes.dart';
import '../../domain/entity/order_history.dart';
import 'loading_history_widget.dart';

class OrderHistoryCardWidget extends StatelessWidget {
  const OrderHistoryCardWidget({super.key, required this.orderHistory, this.isDetails = false});

  final OrderHistory orderHistory;
  final bool isDetails;

  @override
  Widget build(BuildContext context) {
    final statusData = getStatus(orderHistory.orderStatus!);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.bgColor,
        borderRadius: AppTheme.bigBorderRadius,
        border: Border.all(color: AppTheme.primaryColor.withOpacity(.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  '${'orderId'.tr}: #${orderHistory.id}',
                  style: AppTheme.textStyle(size: AppTheme.size14, color: AppTheme.textColor, isBold: true),
                ),
              ),
              Image.asset(statusData[1], width: 40, color: AppTheme.primaryColor),
            ],
          ),
          Text(
            '${'orderDate'.tr}: ${SharedHelper.dateFormatToString(orderHistory.creationDate!, withTime: true)}',
            style: AppTheme.textStyle(size: AppTheme.size14, color: AppTheme.textColor.withOpacity(.7)),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          if (orderHistory.isScheduled!) ...[
            const SizedBox(height: 4),
            Text(
              '${orderHistory.deliveryMethodId == 1 ? 'deliveryDate'.tr : 'pickUpDate'.tr}: '
              '${SharedHelper.dateFormatToString(orderHistory.deliveryDate!, withTime: true)}',
              style: AppTheme.textStyle(size: AppTheme.size12, color: AppTheme.textColor.withOpacity(.7)),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(color: AppTheme.primaryColor.withOpacity(.1), borderRadius: BorderRadius.circular(20)),
                child: Text(
                  statusData[0].tr,
                  style: AppTheme.textStyle(size: AppTheme.size12, color: AppTheme.primaryColor, isBold: true),
                ),
              ),
              const Spacer(),
              if (!isDetails)
                SizedBox(
                  height: 32,
                  child: OutlinedButton(
                    onPressed: () {
                      SDKNav.toNamed(RouteConstant.orderDetailsPage, arguments: orderHistory);
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppTheme.primaryColor.withOpacity(.4)),
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    child: Text(
                      'viewOrder'.tr,
                      style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size12, isBold: true),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
