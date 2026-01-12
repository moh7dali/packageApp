import 'package:my_custom_widget/features/loyalty/data/models/point_schema_brand_model.dart';
import 'package:my_custom_widget/shared/helper/shared_helper.dart';

import '../../../../core/api/api_end_points.dart';
import '../../../../core/api/api_request.dart';
import '../../../../core/constants/constants.dart';
import '../../domain/entity/point_schema_brand.dart';
import '../../domain/entity/user_balance_history_list.dart';
import '../../domain/entity/user_loyalty_data.dart';
import '../models/user_balance_history_list_model.dart';
import '../models/user_loyalty_data_model.dart';

abstract class LoyaltyApiDataSource {
  Future<UserBalanceHistoryList> getUserBalanceHistory({required Map<String, dynamic> body});

  Future<UserLoyaltyData> getUserLoyaltyData();

  Future<List<PointSchemaBrand>> getTiersLoyaltyData();
}

class LoyaltyApiDataSourceImpl implements LoyaltyApiDataSource {
  @override
  Future<UserBalanceHistoryList> getUserBalanceHistory({required Map<String, dynamic> body}) async {
    UserBalanceHistoryList userBalanceHistoryList = await ApiRequest<UserBalanceHistoryList>().request(
      method: HttpMethodRequest.getMethode,
      url: ApiEndPoints.getUserBalanceHistory,
      body: {},
      queryParameters: body,
      authorized: true,
      fromJson: UserBalanceHistoryListModel.fromJson,
    );
    return userBalanceHistoryList;
  }

  @override
  Future<UserLoyaltyData> getUserLoyaltyData() async {
    UserLoyaltyData userLoyaltyData = await ApiRequest<UserLoyaltyData>().request(
      method: HttpMethodRequest.getMethode,
      url: ApiEndPoints.getUserLoyaltyData,
      body: {},
      authorized: true,
      fromJson: UserLoyaltyDataModel.fromJson,
    );
    return userLoyaltyData;
  }

  @override
  Future<List<PointSchemaBrand>> getTiersLoyaltyData() async {
    List<PointSchemaBrand>? pointSchemaBrand = await ApiRequest<List<PointSchemaBrand>?>().request(
      method: HttpMethodRequest.getMethode,
      url: ApiEndPoints.getTiersLoyaltyData,
      body: {},
      authorized: await SharedHelper().isUserLoggedIn(),
      fromJson: tierSchemaBrandFromMap,
    );
    return pointSchemaBrand ?? [];
  }
}
