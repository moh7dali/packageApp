import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/features/loyalty/presentation/getx/point_schema_by_business_unit_controller.dart';
import 'package:my_custom_widget/features/loyalty/presentation/widgets/dropdown_schema_by_busniess_unit_wiidget.dart';
import 'package:my_custom_widget/shared/widgets/no_item_widget.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/utils/theme.dart';
import '../../../../shared/helper/shared_helper.dart';
import '../widgets/point_schema_loading_widget.dart';

class PointSchemaPageByBusinessUnit extends StatelessWidget {
  const PointSchemaPageByBusinessUnit({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PointSchemaByBusinessUnit>(
      init: PointSchemaByBusinessUnit(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(title: Text('pointSchema'.tr.toUpperCase())),
          body: Column(
            children: [
              Expanded(
                child: controller.isLoadingSchema
                    ? const PointSchemaLoadingWidget()
                    : Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: SizedBox(
                          child: (controller.pointSchemaList ?? []).isEmpty
                              ? Column(
                                  children: [
                                    NoItemWidget(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "somethingWrong".tr,
                                            style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size14),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : PageView.builder(
                                  scrollDirection: Axis.horizontal,
                                  controller: controller.pageViewController,
                                  itemCount: controller.pointSchemaList?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    double max = controller.minMax.firstWhere(
                                      (element) => element["TierId"] == controller.pointSchemaList![index].tierId,
                                    )["Max"];
                                    double min = controller.minMax.firstWhere(
                                      (element) => element["TierId"] == controller.pointSchemaList![index].tierId,
                                    )["Min"];
                                    return SizedBox(
                                      height: Get.height * .6,
                                      child: Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Card(
                                                margin: EdgeInsets.all(10),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: AppTheme.borderRadius,
                                                  side: BorderSide(color: AppTheme.primaryColor.withOpacity(.4)),
                                                ),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    gradient: AppTheme.gradient1,
                                                    boxShadow: [BoxShadow(color: AppTheme.primaryColor, blurRadius: 10, blurStyle: BlurStyle.outer)],
                                                    borderRadius: AppTheme.borderRadius,
                                                    border: Border.fromBorderSide(BorderSide(color: AppTheme.primaryColor.withOpacity(.4))),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: CachedNetworkImage(
                                                            imageUrl: controller.pointSchemaList![index].imageUrl ?? "",
                                                            width: 50,
                                                            height: 50,
                                                            fit: BoxFit.cover,
                                                            placeholder: (w, e) => Image.asset(AssetsConsts.loading, fit: BoxFit.cover),
                                                            errorWidget: (c, e, s) => Container(),
                                                          ),
                                                        ),
                                                        SizedBox(width: 16),
                                                        Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              controller.pointSchemaList![index].tierName ?? "",
                                                              style: AppTheme.textStyle(
                                                                color: AppTheme.fromHex(
                                                                  controller.pointSchemaList![index].tierColor ?? AppTheme.primaryColorString,
                                                                ),
                                                                size: AppTheme.size18,
                                                                isBold: true,
                                                              ),
                                                            ),
                                                            SizedBox(height: 10),
                                                            Text(
                                                              controller.pointSchemaList![index].tierId == 0
                                                                  ? "${"from".tr} ${SharedHelper.getNumberFormat(min)}  ${'jd'.tr} ${"to".tr} ${SharedHelper.getNumberFormat(max - 1)} ${'jd'.tr}"
                                                                  : controller.pointSchemaList![index].tierId == 1
                                                                  ? "${"from".tr} ${SharedHelper.getNumberFormat(min)}  ${'jd'.tr} ${"to".tr} ${SharedHelper.getNumberFormat(max - 1)} ${'jd'.tr}"
                                                                  : controller.pointSchemaList![index].tierId == 2
                                                                  ? "${"from".tr} ${SharedHelper.getNumberFormat(min)}  ${'jd'.tr} ${"to".tr} ${SharedHelper.getNumberFormat(max - 1)}  ${'jd'.tr}"
                                                                  : "${"above".tr} ${SharedHelper.getNumberFormat(min)}  ${'jd'.tr}",
                                                              style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size10),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 8),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      "brandName".tr,
                                                      style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size18, isBold: true),
                                                    ),
                                                    Text(
                                                      '${'points'.tr} / ${'jd'.tr}',
                                                      style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size16),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 4),
                                                child: Divider(color: AppTheme.primaryColor),
                                              ),
                                              Expanded(
                                                child: DropDownShemaByBusinessUnit(
                                                  businessUnitLoyaltyDataList: controller.pointSchemaList![index].businessUnitLoyaltyDataList,
                                                  selectedBusinessUnit: controller.pointSchemaList![index].businessUnitLoyaltyDataList?.first,
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
