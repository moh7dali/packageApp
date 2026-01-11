import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/theme.dart';
import '../../domain/entity/user_balance_history.dart';

class PointHistoryWidget extends StatelessWidget {
  const PointHistoryWidget({super.key, required this.userBalanceHistory});

  final UserBalanceHistory userBalanceHistory;

  @override
  Widget build(BuildContext context) {
    final pts = userBalanceHistory.numberOfPoints ?? 0;

    final bool isPending = userBalanceHistory.currentStatus == 1;
    final bool isExpired = userBalanceHistory.triggerType == 11;
    final bool isEarned = pts >= 0 && !isExpired;

    final Color statusColor = isPending
        ? Colors.amber
        : isExpired
        ? Colors.red
        : isEarned
        ? Colors.green
        : AppTheme.primaryColor;

    final String dateText = (userBalanceHistory.creationDate ?? "").isNotEmpty
        ? DateFormat('yyyy-MM-dd').format(DateTime.parse(userBalanceHistory.creationDate!))
        : "";

    final String expiryDateText = (userBalanceHistory.expiryDate ?? "").isNotEmpty
        ? DateFormat('yyyy-MM-dd').format(DateTime.parse(userBalanceHistory.expiryDate!))
        : "";

    final String activationDateText = (userBalanceHistory.activationDate ?? "").isNotEmpty
        ? DateFormat('yyyy-MM-dd').format(DateTime.parse(userBalanceHistory.activationDate!))
        : "";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          color:AppTheme.bgThemeColor,
          borderRadius: AppTheme.bigBorderRadius,
          border: Border.all(color: AppTheme.primaryColor),
          boxShadow: [BoxShadow(color: AppTheme.primaryColor.withOpacity(0.06), blurRadius: 12, offset: const Offset(0, 5))],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            children: [
              // Top row
              Row(
                children: [
                  Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 8),

                  Expanded(
                    child: Text(
                      userBalanceHistory.brandName ?? userBalanceHistory.triggerActionName ?? "-",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14, isBold: true),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.10),
                      border: Border.all(color: statusColor.withOpacity(0.35)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "${pts > 0 ? '+' : ''}$pts",
                          style: AppTheme.textStyle(color: statusColor, size: AppTheme.size14, isBold: true),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "points".tr,
                          style: AppTheme.textStyle(color: AppTheme.textColor.withOpacity(.65), size: AppTheme.size12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              _infoLine(icon: Icons.local_offer_outlined, label: "TransactionType".tr, value: userBalanceHistory.triggerActionName ?? "-"),
              const SizedBox(height: 6),
              if (userBalanceHistory.branchName != null)
                _infoLine(icon: Icons.store_outlined, label: "branchName".tr, value: userBalanceHistory.branchName ?? "-"),
              const SizedBox(height: 6),
              _infoLine(icon: Icons.calendar_today_outlined, label: "creationDate".tr, value: dateText.isEmpty ? "-" : dateText),
              if (userBalanceHistory.expiryDate != null) ...[
                const SizedBox(height: 6),
                _infoLine(icon: Icons.auto_delete_outlined, label: "expiryDate".tr, value: expiryDateText.isEmpty ? "-" : expiryDateText),
              ],
              if (userBalanceHistory.activationDate != null) ...[
                const SizedBox(height: 6),
                _infoLine(icon: Icons.auto_delete_outlined, label: "activationDate".tr, value: activationDateText.isEmpty ? "-" : activationDateText),
              ],
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
