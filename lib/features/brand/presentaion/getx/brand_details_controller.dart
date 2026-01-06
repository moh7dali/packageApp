import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:my_custom_widget/features/brand/domain/entities/brand_details.dart";
import "package:my_custom_widget/features/brand/domain/usecases/get_brand_details.dart";

import "../../../../injection_container.dart";
import "../../../../shared/helper/shared_helper.dart";

class BrandDetailsController extends GetxController {
  bool isLoading = true;
  final int brandID;
  final GetBrandDetails brandDetailsUsecase;
  BrandDetails? brandDetails;

  ScrollController scrollController = ScrollController();

  BrandDetailsController(this.brandID) : brandDetailsUsecase = sl();

  @override
  void onInit() {
    super.onInit();
    getBrandDetailsApi();
  }

  getBrandDetailsApi() async {
    isLoading = true;
    update();
    await brandDetailsUsecase.repository.getBrandDetails(queryParameters: {
      "brandId": "$brandID",
    }).then(
      (value) => value.fold(
        (failure) {
          isLoading = false;
          update();
          SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
        },
        (brandsDetailsValue) {
          brandDetails = brandsDetailsValue;
          isLoading = false;
          update();
        },
      ),
    );
  }
}
