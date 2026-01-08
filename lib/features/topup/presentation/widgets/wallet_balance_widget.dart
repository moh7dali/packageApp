import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/sdk/sdk_rouutes.dart';
import '../../../../core/utils/theme.dart';
import '../../../../shared/helper/shared_helper.dart';
import '../../../../shared/widgets/sar_widget.dart';

class WalletBalanceWidget extends StatelessWidget {
  const WalletBalanceWidget({super.key, required this.walletBalance});

  final double? walletBalance;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppTheme.gradient1),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "walletBalance".tr,
              style: AppTheme.textStyle(color: AppTheme.whiteColor.withOpacity(0.9), size: AppTheme.size16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: Get.height * .04),
            CurrencyAmountText(
              amountText: SharedHelper.getNumberFormat(walletBalance ?? 0, isCurrency: true),
              amountStyle: AppTheme.textStyle(color: AppTheme.whiteColor, size: AppTheme.size20).copyWith(fontWeight: FontWeight.w900),
            ),

            SizedBox(height: Get.height * .04),
            GestureDetector(
              onTap: () {
                SDKNav.toNamed(RouteConstant.topUpListScreen);
              },
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppTheme.whiteColor.withOpacity(0.06),
                        borderRadius: AppTheme.bigBorderRadius,
                        border: Border.all(color: AppTheme.whiteColor.withOpacity(0.15), width: 1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.wallet_rounded, color: AppTheme.whiteColor, size: AppTheme.size30),
                          Expanded(
                            child: Text(
                              "topUpYourAccount".tr,
                              textAlign: TextAlign.center,
                              style: AppTheme.textStyle(color: AppTheme.whiteColor, size: AppTheme.size16),
                            ),
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
