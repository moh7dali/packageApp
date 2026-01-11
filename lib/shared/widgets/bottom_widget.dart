import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/core/utils/theme.dart';

class BottomWidget extends StatelessWidget {
  final String title;
  final String description;
  final String cancelText;
  final String confirmText;
  final Color? cancelColor;
  final Color? confirmColor;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  const BottomWidget({
    super.key,
    required this.title,
    required this.description,
    this.cancelText = "cancel",
    this.confirmText = "confirm",
    this.cancelColor,
    this.confirmColor,
    required this.onCancel,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.bgThemeColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                title,
                style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size18, isBold: true),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: AppTheme.textStyle(color: AppTheme.textColor.withOpacity(.75), size: AppTheme.size14),
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cancelColor ?? AppTheme.primaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: onCancel,
                  child: Text(
                    cancelText.tr,
                    style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: confirmColor ?? AppTheme.primaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: onConfirm,
                  child: Text(
                    confirmText.tr,
                    style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14),
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
