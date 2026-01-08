import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:my_custom_widget/features/topup/domain/entities/top_up_history.dart';
import 'package:my_custom_widget/features/topup/domain/usecases/get_customer_wallet_history.dart';

import '../../../../injection_container.dart';
import '../../../../shared/helper/shared_helper.dart';
import '../../../../shared/model/pagination_list_model.dart';

class GetCustomerWalletHistoryController extends GetxController {
  final GetCustomerWalletHistory getCustomerWalletHistory;

  GetCustomerWalletHistoryController() : getCustomerWalletHistory = sl();

  List<TopUpHistory> topUpHistoryList = [];

  ScrollController scrollController = ScrollController();

  Future<PaginationListModel> getTopUpHistoryApi({int page = 1}) async {
    topUpHistoryList = [];
    int totalNumberOfResult = 0;
    await getCustomerWalletHistory.repository
        .getCustomerWalletHistory(body: {"PageNumber": "$page"})
        .then(
          (value) => value.fold(
            (failure) {
              SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
            },
            (list) {
              List<TopUpHistory> topUpForSize = list.customerWalletHistoryModelList ?? [];
              topUpHistoryList = topUpForSize;
              totalNumberOfResult = list.totalNumberofResult ?? 0;
              update();
            },
          ),
        );
    return PaginationListModel(totalNumberOfResult: totalNumberOfResult, listOfObjects: topUpHistoryList);
  }
}
