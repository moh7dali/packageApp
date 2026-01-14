import 'package:mozaic_loyalty_sdk/features/home/data/models/home_details_model.dart';
import 'package:mozaic_loyalty_sdk/features/home/domain/entities/home_details.dart';

import '../../../../core/api/api_end_points.dart';
import '../../../../core/api/api_request.dart';
import '../../../../core/constants/constants.dart';

abstract class HomeApiDataSource {
  Future<HomeDetails> getHomeDetails({required Map<String, dynamic> body});

  Future<HomeDetails> getCustomerHomeContents({required Map<String, dynamic> body});
}

class HomeApiDataSourceImpl implements HomeApiDataSource {
  @override
  Future<HomeDetails> getHomeDetails({required Map<String, dynamic> body}) async {
    HomeDetails homeDetails = await ApiRequest<HomeDetails>().request(
      method: HttpMethodRequest.postMethode,
      url: ApiEndPoints.getHomeContents,
      body: body,
      fromJson: HomeDetailsModel.fromMap,
    );
    return homeDetails;
  }

  @override
  Future<HomeDetails> getCustomerHomeContents({required Map<String, dynamic> body}) async {
    HomeDetails homeDetails = await ApiRequest<HomeDetails>().request(
      method: HttpMethodRequest.postMethode,
      url: ApiEndPoints.getCustomerHomeContents,
      body: body,
      authorized: true,
      fromJson: HomeDetailsModel.fromMap,
    );
    return homeDetails;
  }
}
