import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/utils/theme.dart';

class SuperPremiumReferAndEarnButton extends StatefulWidget {
  const SuperPremiumReferAndEarnButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  State<SuperPremiumReferAndEarnButton> createState() => _SuperPremiumReferAndEarnButtonState();
}

class _SuperPremiumReferAndEarnButtonState extends State<SuperPremiumReferAndEarnButton> {
  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: 1.0,
      duration: const Duration(milliseconds: 120),
      curve: Curves.easeOut,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          padding: const EdgeInsets.all(1.6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [AppTheme.primaryColor.withOpacity(.65), AppTheme.primaryColor.withOpacity(.35)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [BoxShadow(color: AppTheme.primaryColor.withOpacity(.18), blurRadius: 16, offset: const Offset(0, 6))],
          ),
          child: Container(
            decoration: BoxDecoration(color: const Color(0xFFF7F9F8).withOpacity(0.96), borderRadius: BorderRadius.circular(18)),
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Image.asset(AssetsConsts.shareIcon, height: Get.height * .1),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Refer&Win".tr,
                        style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size16, isBold: true),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "referAndWinDescription".tr,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTheme.textStyle(color: AppTheme.textColor.withOpacity(.7), size: AppTheme.size11),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  height: 34,
                  width: 34,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: [AppTheme.primaryColor, AppTheme.primaryColor.withOpacity(0.85)]),
                    boxShadow: [BoxShadow(color: AppTheme.primaryColor.withOpacity(.35), blurRadius: 12, offset: const Offset(0, 4))],
                  ),
                  child: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.white),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
