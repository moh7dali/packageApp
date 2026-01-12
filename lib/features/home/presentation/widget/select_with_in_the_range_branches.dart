import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/features/home/presentation/getx/home_controller.dart';
import 'package:my_custom_widget/shared/helper/shared_helper.dart';
import 'package:my_custom_widget/shared/widgets/button_widget.dart';

import '../../../../core/utils/theme.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../../branch/domain/entities/branch_details.dart';
import '../../../main/presentation/getx/main_controller.dart';

class SelectWithInTheRangeBranches extends StatelessWidget {
  SelectWithInTheRangeBranches({super.key, required this.withinTheRangeBranches, required this.mainController});

  List<BranchDetails> withinTheRangeBranches;
  HomeController mainController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'branches'.tr,
            style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size18, isBold: true),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: Get.height * .25,
            child: CupertinoPicker(
              itemExtent: 40,
              onSelectedItemChanged: (int index) {
                mainController.selectedBranch = withinTheRangeBranches[index];
              },
              children: withinTheRangeBranches
                  .map((e) => Center(
                        child: Text(e.name ?? "", style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size16)),
                      ))
                  .toList(),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          AppButton(
            title: "done".tr,
            function: () {
              SharedHelper().bottomSheet(BottomLoadingWidget());
              mainController.checkInUser(mainController.selectedBranch!);
            },
          ),
        ],
      ),
    );
  }
}
