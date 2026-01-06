import "package:flutter/material.dart";
import "package:get/get.dart";

import "../../../../injection_container.dart";
import "../../domain/entities/user_barcode.dart";
import "../../domain/usecases/get_uaer_barcode.dart";

enum LoyaltySource { points, wallet }

class UserBarcodeController extends GetxController with GetTickerProviderStateMixin {
  Map<String, dynamic> data = {};
  UserBarcode? userBarcode;
  final GetUserBarcode getUserBarcode;
  bool isLoading = true;

  late AnimationController _controller;
  late Animation<double> animation;
  LoyaltySource? selectedSource;

  UserBarcodeController() : getUserBarcode = sl();

  @override
  void onInit() {
    super.onInit();
    _controller = AnimationController(duration: const Duration(seconds: 2), vsync: this)..repeat(reverse: true);

    animation = Tween<double>(begin: 0, end: 20).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    getUserBarcodeAPI();
  }

  @override
  void onClose() {
    _controller.dispose();
    super.onClose();
  }

  Future<void> getUserBarcodeAPI() async {
    await getUserBarcode.repository.getUserBarcode().then(
      (value) => value.fold(
        (failure) {
          isLoading = false;
          update();
        },
        (userBarcodeData) {
          userBarcode = userBarcodeData;
          _handleBalancesAndBuildPayload(userBarcodeData);
        },
      ),
    );
  }

  void _handleBalancesAndBuildPayload(UserBarcode barcode) {
    final cash = (barcode.cashBalance ?? 0);
    final wallet = (barcode.walletBalance ?? 0);

    if (cash == 0 && wallet == 0) {
      selectedSource = LoyaltySource.points;
      data = _buildQrPayload(barcode, source: selectedSource!);
      isLoading = false;
      update();
      return;
    }

    if (cash > 0 && wallet == 0) {
      selectedSource = LoyaltySource.points;
      data = _buildQrPayload(barcode, source: selectedSource!);
      isLoading = false;
      update();
      return;
    }

    if (cash == 0 && wallet > 0) {
      selectedSource = LoyaltySource.wallet;
      data = _buildQrPayload(barcode, source: selectedSource!);
      isLoading = false;
      update();
      return;
    }

    if (cash > 0 && wallet > 0) {
      selectedSource = null;
      isLoading = false;
      update();
      return;
    }
  }

  void selectSource(LoyaltySource source) {
    if (userBarcode == null) return;

    selectedSource = source;
    data = _buildQrPayload(userBarcode!, source: source);
    isLoading = false;
    update();
  }

  bool get shouldShowSourceChoice {
    final cash = (userBarcode?.cashBalance ?? 0);
    final wallet = (userBarcode?.walletBalance ?? 0);
    return cash > 0 && wallet > 0;
  }

  Map<String, dynamic> _buildQrPayload(UserBarcode barcode, {required LoyaltySource source}) {
    final rawMobile = (barcode.mobileNumber ?? '').trim();

    int? countryCode;
    String mobileNumber = rawMobile;

    final regWithPlus = RegExp(r'^\+(\d{1,3})(\d+)$');
    final matchWithPlus = regWithPlus.firstMatch(rawMobile);

    if (matchWithPlus != null) {
      countryCode = int.parse(matchWithPlus.group(1)!);
      mobileNumber = matchWithPlus.group(2)!;
    } else {
      final digitsOnly = rawMobile.replaceAll(RegExp(r'[^0-9]'), '');
      if (digitsOnly.length > 9) {
        countryCode = int.parse(digitsOnly.substring(0, digitsOnly.length - 9));
        mobileNumber = digitsOnly.substring(digitsOnly.length - 9);
      } else {
        countryCode = null;
        mobileNumber = digitsOnly;
      }
    }

    final rewardCode = _buildLoyaltyCode(barcode.redeemCode ?? "", source: source);

    print("mobile is $mobileNumber");
    print("mobile_country_code is $countryCode");
    print("reward_code is $rewardCode");

    return {
      "customer_name": barcode.fullName ?? "",
      "customer_mobile_number": mobileNumber,
      "mobile_country_code": countryCode,
      "reward_code": rewardCode,
    };
  }

  String _buildLoyaltyCode(String rawCode, {required LoyaltySource source}) {
    if (rawCode.isEmpty) return rawCode;
    return source == LoyaltySource.wallet ? 'WAL-$rawCode' : 'PRO-$rawCode';
  }
}
