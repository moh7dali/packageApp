import "package:get/get.dart";
import "package:mozaic_loyalty_sdk/features/branch/domain/entities/branch_details.dart";
import "package:mozaic_loyalty_sdk/features/branch/domain/usecases/get_branch_details.dart";

import "../../../../injection_container.dart";
import "../../../../shared/helper/shared_helper.dart";

class BranchDetailsController extends GetxController {
  bool isLoading = true;
  final int branchID;
  final GetBranchDetails branchDetailsUsecase;
  BranchDetails? branchDetails;

  BranchDetailsController(this.branchID) : branchDetailsUsecase = sl();

  @override
  void onInit() {
    super.onInit();
    getBranchDetailsApi();
  }

  getBranchDetailsApi() async {
    await branchDetailsUsecase.repository.getBranchDetails(queryParameters: {
      // "merchantId": "${AppConstants.merchantId}",
      "branchId": "$branchID",
    }).then(
      (value) => value.fold(
        (failure) {
          isLoading = false;
          update();
          SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
        },
        (brandsDetailsValue) {
          branchDetails = brandsDetailsValue;
          isLoading = false;
          update();
        },
      ),
    );
  }
}
