import 'package:my_custom_widget/core/constants/constants.dart';
import 'package:my_custom_widget/features/menu/domain/entity/merchant_info.dart';
import 'package:get/get.dart';

import '../../features/menu/domain/usecases/get_merchant_info.dart';
import '../../injection_container.dart';
import '../helper/shared_helper.dart';

class MerchantInfoController extends GetxController {
  final GetMerchantContactInfo getMerchantContactInfo;

  MerchantInfoController() : getMerchantContactInfo = sl();
  MerchantInfo? merchantInfo;
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    getMerchantContactInfoApi();
  }

  getMerchantContactInfoApi() async {
    await getMerchantContactInfo.repository
        .getMerchantContactInfo(body: {"merchantId": AppConstants.merchantId.toString()}).then((value) => value.fold((failure) {
              SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
              isLoading = false;
              update();
            }, (value) {
              merchantInfo = value;
              isLoading = false;
              update();
            }));
  }
}
