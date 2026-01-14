import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mozaic_loyalty_sdk/features/barcode/presentation/getx/user_barcode_controller.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/utils/theme.dart';
import '../../../../shared/helper/shared_helper.dart';
import '../../../../shared/widgets/sar_widget.dart';

class BarcodeScreen extends StatelessWidget {
  const BarcodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserBarcodeController>(
      init: UserBarcodeController(),
      builder: (controller) => Scaffold(
        backgroundColor: Colors.transparent,
        body: GestureDetector(
          onTap: () => SharedHelper().closeAllDialogs(),
          child: Container(
            color: Colors.black.withOpacity(0.45),
            child: Center(
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: Get.width * 0.90,
                  constraints: BoxConstraints(maxHeight: Get.height * 0.55),
                  decoration: BoxDecoration(
                    gradient: AppTheme.gradient1,
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: AppTheme.whiteColor.withOpacity(0.18)),
                    boxShadow: [
                      BoxShadow(color: AppTheme.primaryColor.withOpacity(0.28), blurRadius: 30, offset: const Offset(0, 18)),
                      BoxShadow(color: Colors.black.withOpacity(0.18), blurRadius: 30, offset: const Offset(0, 18)),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Stack(
                      children: [
                        BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(color: Colors.white.withOpacity(0.06)),
                        ),
                        Positioned(
                          top: -40,
                          right: -60,
                          child: Transform.rotate(
                            angle: 0.45,
                            child: Container(
                              width: 220,
                              height: 120,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [Colors.white.withOpacity(0.20), Colors.white.withOpacity(0.00)]),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                          child: Column(
                            children: [
                              Container(
                                width: 52,
                                height: 5,
                                decoration: BoxDecoration(color: Colors.white.withOpacity(0.35), borderRadius: BorderRadius.circular(10)),
                              ),
                              SizedBox(height: Get.height * .05),
                              if (controller.shouldShowSourceChoice && controller.selectedSource == null) ...[
                                const Spacer(),
                                GestureDetector(
                                  onTap: () => controller.selectSource(LoyaltySource.points),
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(.15),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: Colors.white.withOpacity(.40)),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.loyalty_rounded, color: Colors.white, size: 36),
                                        const SizedBox(height: 8),
                                        Text(
                                          "redeemPoints".tr,
                                          style: AppTheme.textStyle(color: AppTheme.whiteColor, size: AppTheme.size16),
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "${"balance".tr}: ",
                                              style: AppTheme.textStyle(color: AppTheme.whiteColor, size: AppTheme.size14, isBold: true),
                                            ),
                                            CurrencyAmountText(
                                              amountText: SharedHelper.getNumberFormat(controller.userBarcode?.cashBalance ?? 0),
                                              amountStyle: AppTheme.textStyle(
                                                color: AppTheme.whiteColor.withOpacity(.85),
                                                size: AppTheme.size14,
                                                isBold: true,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                GestureDetector(
                                  onTap: () => controller.selectSource(LoyaltySource.wallet),
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(.15),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: Colors.white.withOpacity(.40)),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.account_balance_wallet_rounded, color: Colors.white, size: 36),
                                        const SizedBox(height: 8),
                                        Text(
                                          "useWallet".tr,
                                          style: AppTheme.textStyle(color: AppTheme.whiteColor, size: AppTheme.size16, isBold: true),
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "${"balance".tr}: ",
                                              style: AppTheme.textStyle(color: AppTheme.whiteColor, size: AppTheme.size14, isBold: true),
                                            ),
                                            CurrencyAmountText(
                                              amountText: SharedHelper.getNumberFormat(controller.userBarcode?.walletBalance ?? 0),
                                              amountStyle: AppTheme.textStyle(color: AppTheme.whiteColor, size: AppTheme.size14, isBold: true),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Spacer(),
                              ] else ...[
                                AnimatedBuilder(
                                  animation: controller.animation,
                                  builder: (context, child) {
                                    return Transform.translate(
                                      offset: Offset(0, controller.animation.value),
                                      child: Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(14),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.92),
                                          borderRadius: BorderRadius.circular(22),
                                          border: Border.all(color: AppTheme.primaryColor.withOpacity(0.12)),
                                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.10), blurRadius: 18, offset: const Offset(0, 10))],
                                        ),
                                        child: AspectRatio(
                                          aspectRatio: 1,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(18),
                                            child: Container(
                                              color: Colors.white,
                                              padding: const EdgeInsets.all(14),
                                              child: controller.isLoading
                                                  ? Lottie.asset(AssetsConsts.qrCodeLoading)
                                                  : QrImageView(
                                                      data: json.encode(controller.data),
                                                      version: QrVersions.auto,
                                                      backgroundColor: Colors.transparent,
                                                      eyeStyle: const QrEyeStyle(eyeShape: QrEyeShape.square, color: Colors.black),
                                                      dataModuleStyle: const QrDataModuleStyle(
                                                        dataModuleShape: QrDataModuleShape.square,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                const Spacer(),
                                Text(
                                  "scanQR".tr,
                                  style: AppTheme.textStyle(color: AppTheme.whiteColor, size: AppTheme.size20, isBold: true),
                                  textAlign: TextAlign.center,
                                ),
                                const Spacer(),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
