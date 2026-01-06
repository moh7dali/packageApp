import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/features/rate/domian/usecases/rate_branch_visit.dart';
import 'package:my_custom_widget/injection_container.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../shared/helper/shared_helper.dart';
import '../../../../shared/model/push_notification_model.dart';
import '../../../../shared/widgets/loading_button_widget/progress_button.dart';
import '../../../../shared/widgets/shake_widget.dart';

class RateController extends GetxController {
  final RateBranchVisit rateBranchVisit;

  RateController({required this.notification}) : rateBranchVisit = sl();

  int selectedIndex = -1;
  List imageListName = [AssetsConsts.cryIcon, AssetsConsts.sadIcon, AssetsConsts.normalIcon, AssetsConsts.happyIcon, AssetsConsts.veryHappyIcon];
  final PushNotificationModel notification;
  bool isLoading = false;
  final TextEditingController rateController = TextEditingController();
  final rateShake = GlobalKey<ShakeWidgetState>();
  final rateTextShake = GlobalKey<ShakeWidgetState>();
  double rateValue = 0;
  ButtonState btnState = ButtonState.normal;

  rateVisit() async {
    isLoading = true;
    btnState = ButtonState.loading;
    update();

    await rateBranchVisit.repository.rateBranchVisit(body: {
      "BranchId": notification.bri,
      "RateValue": rateValue,
      "TransactionId": notification.tid,
      "Feedback": rateController.text
    }).then((value) => value.fold((failure) {
          isLoading = false;
          btnState = ButtonState.fail;
          update();
          SharedHelper().closeAllDialogs();
          SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
        }, (r) {
          isLoading = false;
          btnState = ButtonState.success;
          update();
          SharedHelper().closeAllDialogs();
          Fluttertoast.showToast(msg: "thanksForRating".tr, gravity: ToastGravity.BOTTOM);
        }));
  }
}
