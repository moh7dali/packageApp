import 'package:my_custom_widget/core/constants/assets_constants.dart';
import 'package:my_custom_widget/features/order_method/presentation/pages/selected_order_method.dart';
import 'package:my_custom_widget/shared/helper/shared_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/widgets/translated_image_widget.dart';

class OrderMethodPopup extends StatelessWidget {
  const OrderMethodPopup({super.key, required this.onFinish});

  final void Function() onFinish;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // GestureDetector(
          //   onTap: () {
          //     SharedHelper().closeAllDialogs();
          //     SharedHelper().scaleDialog(SelectedOrderMethod(onFinish: onFinish));
          //   },
          //   child: TranslatedImageWidget(imgAr: AssetsConsts.pickUpEn, imgEn: AssetsConsts.pickUpEn),
          // ),
          SizedBox(height: Get.height * .05),
          // GestureDetector(
          //   onTap: () {
          //     SharedHelper().closeAllDialogs();
          //     SharedHelper().scaleDialog(SelectedOrderMethod(isPickUp: false, onFinish: onFinish));
          //   },
          //   child: TranslatedImageWidget(imgAr: AssetsConsts.pickUpEn, imgEn: AssetsConsts.pickUpEn),
          // ),
        ],
      ),
    );
  }
}
