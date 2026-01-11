import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/shared/widgets/sar_widget.dart';

import '../../../../core/utils/theme.dart';
import '../../../../shared/helper/shared_helper.dart';
import '../../domain/entities/top_up_history.dart';

class TopUpHistoryWidget extends StatelessWidget {
  const TopUpHistoryWidget({super.key, required this.value});

  final TopUpHistory value;

  @override
  Widget build(BuildContext context) {
    final bool isTopUp = value.transactionType == 1;

    final icon = isTopUp ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded;
    final Color statusColor = isTopUp ? AppTheme.primaryColor : AppTheme.redColor;

    final String amountText = SharedHelper.getNumberFormat(value.purchaseAmount ?? 0);
    final String dateText = SharedHelper.dateFormatToString(value.creationDate ?? DateTime.now(), withTime: true);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.bgThemeColor,
          borderRadius: AppTheme.bigBorderRadius,
          border: Border.all(color: AppTheme.primaryColor),
          boxShadow: [BoxShadow(color: AppTheme.primaryColor.withOpacity(0.06), blurRadius: 12, offset: const Offset(0, 5))],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            children: [
              // 🔹 Top Row (Replaced the circle ➜ Icon box)
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(color: statusColor.withOpacity(0.1), shape: BoxShape.circle),
                    child: Icon(icon, size: 22, color: statusColor),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      value.transactionTypeName ?? "-",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14, isBold: true),
                    ),
                  ),

                  const SizedBox(width: 10),

                  // Amount pill
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: statusColor.withOpacity(0.35)),
                    ),
                    child: CurrencyAmountText(
                      amountText: "${isTopUp ? '+' : '-'}$amountText",
                      amountStyle: AppTheme.textStyle(color: statusColor, size: AppTheme.size14, isBold: true),
                      currencyStyle: AppTheme.textStyle(color: AppTheme.textColor.withOpacity(.65), size: AppTheme.size12),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _infoLine(icon: Icons.calendar_today_outlined, label: "creationDate".tr, value: dateText),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoLine({required IconData icon, required String label, required String value}) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppTheme.primaryColor.withOpacity(0.7)),
        const SizedBox(width: 8),
        Text(
          "$label: ",
          style: AppTheme.textStyle(color: AppTheme.textColor.withOpacity(0.65), size: AppTheme.size12),
        ),
        Expanded(
          child: Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
            style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size12, isBold: true),
          ),
        ),
      ],
    );
  }
}
