import 'package:my_custom_widget/core/constants/constants.dart';
import 'package:get/get.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../injection_container.dart';
import '../../../../shared/helper/payment_helper.dart';
import '../../../../shared/helper/shared_helper.dart';
import '../../../../shared/model/pagination_list_model.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../domain/entities/top_up_list.dart';
import '../../domain/usecases/get_top_up.dart';
import '../../domain/usecases/purchase_top_up.dart';

class TopUpListController extends GetxController {
  final GetTopUp getTopUp;
  final PurchaseTopUp purchaseTopUp;

  TopUpListController() : getTopUp = sl(), purchaseTopUp = sl();

  List<TopUp> topUpList = [];

  int quantity = 1;

  void increase() {
    quantity++;
    update();
  }

  void decrease() {
    quantity = quantity > 1 ? quantity - 1 : 1;
    update();
  }

  Future<PaginationListModel> getTopUpApi({int page = 1}) async {
    topUpList = [];
    int totalNumberOfResult = 0;
    await getTopUp.repository
        .getTopUp(body: {"pageNumber": "$page"})
        .then(
          (value) => value.fold(
            (failure) {
              SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
            },
            (list) {
              List<TopUp> topUpForSize = list.topUp ?? [];
              topUpList = topUpForSize;
              totalNumberOfResult = list.totalNumberofResult ?? 0;
              update();
            },
          ),
        );
    return PaginationListModel(totalNumberOfResult: totalNumberOfResult, listOfObjects: topUpList);
  }

  Future<void> pay({required TopUp topUp}) async {
    SharedHelper().scaleDialog(const LoadingWidget(), dismissible: false);
    await purchaseTopUp.repository
        .purchaseTopUp(body: {"BrandId": AppConstants.brandId, "TopUpId": topUp.id, "Quantity": quantity})
        .then(
          (value) => value.fold(
            (failure) {
              SharedHelper().closeAllDialogs();
              SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
            },
            (result) {
              if (result.paymentToken != null) {
                Get.back();
                payWithPayMob(
                  paymentToken: result.paymentToken!,
                  onSuccessful: () {
                    orderDone();
                  },
                  onRejected: () {
                    orderFail();
                  },
                  onPending: () {
                    orderPending();
                  },
                );
              }
            },
          ),
        );
  }

  void orderDone() {
    SharedHelper().closeAllDialogs();
    Map<String, int> pageIndex = {'index': 0};
    Get.deleteAll();
    Get.offAllNamed(RouteConstant.mainPage, arguments: pageIndex);
    SharedHelper().actionDialog(
      isRowStyle: false,
      "topUpSuccessful",
      "topUpSuccessfulSubText",
      height: Get.height * .2,
      hasImage: true,
      image: AssetsConsts.done,
      isCenter: true,
      isLocalImage: true,
      confirmText: "done",
      confirm: () {
        SharedHelper().closeAllDialogs();
      },
      noCancel: true
    );
  }

  void orderPending() {
    SharedHelper().closeAllDialogs();
    Get.offAllNamed(RouteConstant.mainPage);
    SharedHelper().actionDialog(
      "orderPending",
      "paymentPendingMessage",
      height: Get.height * .2,
      hasImage: true,
      image: AssetsConsts.pending,
      isCenter: true,
      isLocalImage: true,
      confirmText: "done",
      noCancel: true,
      confirm: () {
        SharedHelper().closeAllDialogs();
      },
    );
  }

  void orderFail() {
    SharedHelper().actionDialog(
      "orderFailed",
      "paymentFailedMessage",
      height: Get.height * .3,
      hasImage: true,
      image: AssetsConsts.paymentFailed,
      isCenter: true,
      isLocalImage: true,
      noCancel: true,
      confirmText: "done",
      confirm: () {
        SharedHelper().closeAllDialogs();
      },
    );
  }
}
