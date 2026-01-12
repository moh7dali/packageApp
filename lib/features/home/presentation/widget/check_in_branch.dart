import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/shared/helper/shared_helper.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/sdk/sdk_rouutes.dart';
import '../../../../core/utils/theme.dart';
import '../../../branch/domain/entities/branch_details.dart';

class CheckInBranches extends StatelessWidget {
  CheckInBranches({super.key, required this.selectedBranch, required this.isOutBranch});

  BranchDetails selectedBranch;
  bool isOutBranch;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(color: AppTheme.textColor.withOpacity(.2), shape: BoxShape.circle),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Icon(isOutBranch ? Icons.error_outline_rounded : Icons.check, size: Get.height * .065, color: AppTheme.primaryColor),
            ),
          ),
          SizedBox(height: Get.height * .05),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  isOutBranch ? "checkInNotComplete".tr : "checkInComplete".tr,
                  style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size16),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          SizedBox(height: Get.height * .01),
          GestureDetector(
            onTap: () {
              SharedHelper().closeAllDialogs();
              SDKNav.toNamed(RouteConstant.branchDetailsPage, arguments: selectedBranch.id!);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    selectedBranch.name ?? "",
                    textAlign: TextAlign.center,
                    style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size18),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: Get.height * .01),
        ],
      ),
    );
  }
}
