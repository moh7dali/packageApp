import 'package:my_custom_widget/features/topup/data/models/top_up_history_model.dart';
import 'package:my_custom_widget/features/topup/data/models/top_up_list_model.dart';
import 'package:my_custom_widget/features/topup/data/models/top_up_purchase_result_model.dart';
import 'package:my_custom_widget/features/topup/domain/entities/purchase.dart';
import 'package:my_custom_widget/features/topup/domain/entities/top_up_history.dart';
import 'package:my_custom_widget/features/topup/domain/entities/top_up_list.dart';

import '../../../../core/api/api_end_points.dart';
import '../../../../core/api/api_request.dart';
import '../../../../core/constants/constants.dart';

abstract class TopUpApiDataSource {
  Future<TopUpList> getTopUp({required Map<String, dynamic> body});

  Future<TopUpPurchaseResult> purchase({required Map<String, dynamic> body});

  Future<TopUpHistoryList> getCustomerWalletHistory({required Map<String, dynamic> body});
}

class TopUpApiDataSourceImpl implements TopUpApiDataSource {
  @override
  Future<TopUpList> getTopUp({required Map<String, dynamic> body}) async {
    TopUpList topUpList = await ApiRequest<TopUpList>().request(
      method: HttpMethodRequest.getMethode,
      url: ApiEndPoints.getTopUp,
      body: {},
      queryParameters: body,
      authorized: true,
      fromJson: TopUpListModel.fromJson,
    );
    return topUpList;
  }

  @override
  Future<TopUpPurchaseResult> purchase({required Map<String, dynamic> body}) async {
    TopUpPurchaseResult purchaseResult = await ApiRequest<TopUpPurchaseResult>().request(
      method: HttpMethodRequest.postMethode,
      url: ApiEndPoints.purchase,
      body: body,
      authorized: true,
      fromJson: TopUpPurchaseResultModel.fromJson,
    );
    return purchaseResult;
  }

  @override
  Future<TopUpHistoryList> getCustomerWalletHistory({required Map<String, dynamic> body}) async {
    TopUpHistoryList topUpHistoryList = await ApiRequest<TopUpHistoryList>().request(
      method: HttpMethodRequest.postMethode,
      url: ApiEndPoints.getCustomerWalletHistory,
      body: body,
      authorized: true,
      fromJson: TopUpHistoryListModel.fromJson,
    );
    return topUpHistoryList;
  }
}
