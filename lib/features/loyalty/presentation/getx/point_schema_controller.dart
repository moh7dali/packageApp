import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mozaic_loyalty_sdk/features/loyalty/domain/entity/point_schema_brand.dart';
import 'package:mozaic_loyalty_sdk/features/loyalty/domain/usecase/get_tiers_loyalty_data.dart';

import '../../../../injection_container.dart';
import '../../../../shared/helper/shared_helper.dart';

class PointSchemaController extends GetxController {
  final GetTiersLoyaltyData getTiersLoyaltyData;

  PointSchemaController() : getTiersLoyaltyData = sl();

  List<PointSchemaBrand>? pointSchemaList;
  List<Map<String, dynamic>> minMax = [];
  bool isLoadingSchema = true;
  final pageViewController = PageController(initialPage: 0, viewportFraction: 0.75);
  int currentIndex = 0;

  @override
  onInit() {
    getPointSchema();
    super.onInit();
  }

  getPointSchema() async {
    await getTiersLoyaltyData.repository.getTiersLoyaltyData().then((value) => value.fold((failure) {
      SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
      isLoadingSchema = false;
      update();
    }, (valOfPointSchemaList) {
      pointSchemaList = valOfPointSchemaList;
      for (int i = 0; i < pointSchemaList!.length; i++) {
        double max = 0;
        if (i < pointSchemaList!.length - 1) {
          max = pointSchemaList![i + 1].tierData?.lowerLimit?.toDouble() ?? 1;
        }
        minMax
            .add({"Min": pointSchemaList![i].tierData?.lowerLimit?.toDouble() ?? 0, "Max": max, "TierId": pointSchemaList![i].tierData?.id ?? 0});
        print("name of tier is :${pointSchemaList![i].tierData?.name ?? ""}");
      }
      isLoadingSchema = false;
      update();
    }));
  }
}

