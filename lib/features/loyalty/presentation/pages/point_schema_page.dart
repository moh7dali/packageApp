import 'package:my_custom_widget/core/utils/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../shared/helper/shared_helper.dart';
import '../../../../shared/widgets/sar_widget.dart';
import '../getx/point_schema_controller.dart';
import '../widgets/point_schema_loading_widget.dart';

class PointSchemaPage extends StatelessWidget {
  const PointSchemaPage({super.key});

  Widget build(BuildContext context) {
    return GetBuilder<PointSchemaController>(
      init: PointSchemaController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: GestureDetector(
            onTap: () => SharedHelper().closeAllDialogs(),
            child: Container(
              color: Colors.black.withOpacity(.35),
              child: Center(
                child: GestureDetector(
                  onTap: () {},
                  child: SizedBox(
                    height: Get.height * .4,
                    child: controller.isLoadingSchema
                        ? const PointSchemaLoadingWidget()
                        : Container(
                            margin: const EdgeInsets.symmetric(horizontal: 18),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(28),
                              gradient: AppTheme.gradient1,
                              boxShadow: [BoxShadow(color: Colors.black.withOpacity(.18), blurRadius: 30, offset: const Offset(0, 18))],
                              border: Border.all(color: Colors.white.withOpacity(.14)),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(28),
                              child: Container(
                                decoration: BoxDecoration(color: Colors.white.withOpacity(.08)),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 44,
                                                  height: 44,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white.withOpacity(.12),
                                                    borderRadius: BorderRadius.circular(16),
                                                    border: Border.all(color: Colors.white.withOpacity(.16)),
                                                  ),
                                                  child: const Icon(Icons.stars_rounded, color: Colors.white),
                                                ),
                                                const SizedBox(width: 10),
                                                Text(
                                                  "tier".tr,
                                                  style: AppTheme.textStyle(color: Colors.white, size: AppTheme.size16, isBold: true),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                '${'points'.tr} / ',
                                                style: AppTheme.textStyle(color: Colors.white.withOpacity(.85), size: AppTheme.size12),
                                              ),
                                              SarWidget(size: 12, color: Colors.white.withOpacity(.85)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(26), topRight: Radius.circular(26)),
                                        ),
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          padding: EdgeInsets.zero,
                                          itemCount: controller.pointSchemaList?.length ?? 0,
                                          itemBuilder: (context, index) {
                                            double max = controller.minMax.firstWhere(
                                              (element) => element["TierId"] == controller.pointSchemaList![index].tierData!.id,
                                            )["Max"];
                                            double min = controller.minMax.firstWhere(
                                              (element) => element["TierId"] == controller.pointSchemaList![index].tierData!.id,
                                            )["Min"];

                                            final tierColor = AppTheme.fromHex(
                                              controller.pointSchemaList![index].tierData?.tierColor ?? AppTheme.primaryColorString,
                                            );
                                            return Padding(
                                              padding: const EdgeInsets.only(bottom: 10),
                                              child: Container(
                                                padding: const EdgeInsets.all(12),
                                                decoration: BoxDecoration(
                                                  color: tierColor.withOpacity(.06),
                                                  borderRadius: AppTheme.bigBorderRadius,
                                                  border: Border.all(color: tierColor.withOpacity(.18)),
                                                  boxShadow: [
                                                    BoxShadow(color: Colors.black.withOpacity(.04), blurRadius: 16, offset: const Offset(0, 10)),
                                                  ],
                                                ),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 52,
                                                      height: 52,
                                                      child: ClipRRect(
                                                        borderRadius: AppTheme.borderRadius,
                                                        child: CachedNetworkImage(
                                                          imageUrl: controller.pointSchemaList![index].tierData?.imageUrl ?? "",
                                                          fit: BoxFit.cover,
                                                          placeholder: (w, e) => Image.asset(AssetsConsts.loading, fit: BoxFit.cover),
                                                          errorWidget: (c, e, s) => SvgPicture.asset(AssetsConsts.iconLogo, width: 34),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 12),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            controller.pointSchemaList![index].tierData?.name ?? "",
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: AppTheme.textStyle(color: tierColor, size: AppTheme.size16, isBold: true),
                                                          ),
                                                          const SizedBox(height: 6),
                                                          if (controller.minMax.length > 1)
                                                            Row(
                                                              mainAxisSize: MainAxisSize.min,
                                                              children: [
                                                                Text(
                                                                  index != (controller.pointSchemaList!.length - 1)
                                                                      ? "${"from".tr} ${SharedHelper.getNumberFormat(min)} "
                                                                      : "${"above".tr} ${SharedHelper.getNumberFormat(min)} ",
                                                                  style: AppTheme.textStyle(
                                                                    color: AppTheme.textColor.withOpacity(.75),
                                                                    size: AppTheme.size12,
                                                                  ),
                                                                ),
                                                                SarWidget(size: AppTheme.size12, color: AppTheme.textColor.withOpacity(.75)),
                                                                if (index != (controller.pointSchemaList!.length - 1)) ...[
                                                                  Text(
                                                                    " ${"to".tr} ${SharedHelper.getNumberFormat(max - 1)} ",
                                                                    style: AppTheme.textStyle(
                                                                      color: AppTheme.textColor.withOpacity(.75),
                                                                      size: AppTheme.size12,
                                                                    ),
                                                                  ),
                                                                  SarWidget(size: AppTheme.size12, color: AppTheme.textColor.withOpacity(.75)),
                                                                ],
                                                              ],
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                    if ((controller.pointSchemaList?[index].loyaltyDataList ?? []).isNotEmpty)
                                                      Container(
                                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius: BorderRadius.circular(16),
                                                          border: Border.all(color: tierColor.withOpacity(.18)),
                                                        ),
                                                        child: Text(
                                                          (double.parse(
                                                                        ((controller.pointSchemaList?[index].loyaltyDataList?[0].conversionValue ??
                                                                                    0) *
                                                                                100)
                                                                            .toStringAsFixed(2),
                                                                      ) %
                                                                      1 ==
                                                                  0)
                                                              ? (double.parse(
                                                                  ((controller.pointSchemaList?[index].loyaltyDataList?[0].conversionValue ?? 0) *
                                                                          100)
                                                                      .toStringAsFixed(2),
                                                                )).toStringAsFixed(0)
                                                              : (double.parse(
                                                                  ((controller.pointSchemaList?[index].loyaltyDataList?[0].conversionValue ?? 0) *
                                                                          100)
                                                                      .toStringAsFixed(2),
                                                                )).toStringAsFixed(1),
                                                          style: AppTheme.textStyle(
                                                            color: AppTheme.primaryColor,
                                                            size: AppTheme.size14,
                                                            isBold: true,
                                                          ),
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
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
          ),
        );
      },
    );
  }
}
