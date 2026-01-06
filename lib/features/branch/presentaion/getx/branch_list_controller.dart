import "package:get/get.dart";

import "../../../../core/utils/app_log.dart";
import "../../../../injection_container.dart";
import "../../../../shared/helper/shared_helper.dart";
import "../../../../shared/model/pagination_list_model.dart";
import "../../domain/entities/branch_details.dart";
import "../../domain/usecases/get_all_branches.dart";

class BranchListController extends GetxController {
  bool isLoading = true;
  final GetAllBranches allBranches;
  List<BranchDetails> brandsList = [];
  final int brandId;

  BranchListController(this.brandId) : allBranches = sl();

  Future<PaginationListModel> getAllBranchesList({int page = 1}) async {
    brandsList = [];
    int totalNumberOfResult = 0;
    await allBranches.repository.getAllBranches(body: {
      "pageNumber": "$page",
      "brandId": "$brandId",
    }).then(
          (value) => value.fold(
            (failure) {
          SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
          isLoading = false;
          update();
        },
            (brandsDetailsList) {
          appLog("brandsDetailsList: ${brandsDetailsList.branches}");
          List<BranchDetails> list = brandsDetailsList.branches ?? [];
          brandsList = list;
          totalNumberOfResult = brandsDetailsList.totalNumberofResult ?? 0;
          isLoading = false;
          update();
        },
      ),
    );
    return PaginationListModel(listOfObjects: brandsList, totalNumberOfResult: totalNumberOfResult);
  }
}
