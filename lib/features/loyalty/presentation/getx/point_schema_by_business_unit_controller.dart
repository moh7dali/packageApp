import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/features/loyalty/domain/entity/point_schema_brand_by_business_unit.dart';
import 'package:my_custom_widget/features/loyalty/domain/usecase/get_tiers_loyalty_data_by_business_unit.dart';

import '../../../../injection_container.dart';
import '../../../../shared/helper/shared_helper.dart';

class PointSchemaByBusinessUnit extends GetxController {
  final GetTiersLoyaltyDataByBusinessUnit getTiersLoyaltyDataByBusinessUnit;

  PointSchemaByBusinessUnit() : getTiersLoyaltyDataByBusinessUnit = sl();

  List<PointSchemaBrandByBusinessUnit>? pointSchemaList;
  List<Map<String, dynamic>> minMax = [];
  bool isLoadingSchema = true;
  final pageViewController = PageController(initialPage: 0, viewportFraction: 0.90);

  @override
  onInit() {
    getPointSchema();
    super.onInit();
  }

  getPointSchema() async {
    await getTiersLoyaltyDataByBusinessUnit.repository.getTiersLoyaltyDataByBusinessUnit().then((value) => value.fold((failure) {
          SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
          isLoadingSchema = false;
          update();
        }, (valOfPointSchemaList) {
          pointSchemaList = valOfPointSchemaList;
          for (int i = 0; i < pointSchemaList!.length; i++) {
            double max = 0;
            if (i < pointSchemaList!.length - 1) {
              max = pointSchemaList![i + 1].tierLowerLimit ?? 1;
            }
            minMax.add({"Min": pointSchemaList![i].tierLowerLimit ?? 0, "Max": max, "TierId": pointSchemaList![i].tierId ?? 0});
          }
          isLoadingSchema = false;
          update();
        }));
  }
}
