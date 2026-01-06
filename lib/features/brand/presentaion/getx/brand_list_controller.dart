import "package:get/get.dart";
import "package:my_custom_widget/features/brand/domain/entities/brand_details.dart";
import "package:my_custom_widget/features/brand/domain/usecases/getAllBrands.dart";

import "../../../../injection_container.dart";
import "../../../../shared/helper/shared_helper.dart";
import "../../../../shared/model/pagination_list_model.dart";

class BrandListController extends GetxController {
  bool isLoading = true;
  final GetAllBrands allBrands;
  List<BrandDetails> brandsList = [];
  final int businessUnitID;

  BrandListController(this.businessUnitID) : allBrands = sl();

  Future<List<BrandDetails>> getAllBrandsList({int page = 1}) async {
    brandsList = [];
    await allBrands.repository.getAllBrands(queryParameters: {
      // "merchantId": "${AppConstants.merchantId}",
      "pageNumber": "$page",
    }).then(
      (value) => value.fold(
        (failure) {
          SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
        },
        (brandsDetailsList) {
          List<BrandDetails> list = brandsDetailsList.brands ?? [];
          brandsList = list;
          update();
        },
      ),
    );
    return brandsList;
  }

  Future<PaginationListModel> getBusinessUnitBrands({int page = 1}) async {
    brandsList = [];
    int totalNumberOfResult = 0;
    await allBrands.repository.getBusinessUnitBrands(queryParameters: {"pageNumber": "$page", "businessUnitId": "$businessUnitID"}).then(
          (value) => value.fold(
            (failure) {
          SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
        },
            (brandsDetailsList) {
          List<BrandDetails> list = brandsDetailsList?.brands ?? [];
          totalNumberOfResult = brandsDetailsList?.totalNumberofResult ?? 0;
          brandsList = list;
          update();
        },
      ),
    );
    return PaginationListModel(listOfObjects: brandsList, totalNumberOfResult: totalNumberOfResult);
  }
}
