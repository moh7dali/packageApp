import 'package:my_custom_widget/features/rewards_gallery/data/models/rewards_gallery_model.dart';
import 'package:my_custom_widget/features/rewards_gallery/domain/entity/reward_gallery.dart';

import '../../../../core/api/api_end_points.dart';
import '../../../../core/api/api_request.dart';
import '../../../../core/api/api_response.dart';
import '../../../../core/constants/constants.dart';

abstract class RewardsGalleryApiDatasource {
  Future<RewardsGalleryList> getGalleryRewards({Map<String, dynamic>? queryParameters});

  Future<dynamic> redeemReward({required Map<String, dynamic> body});
}

class RewardsGalleryApiDatasourceImpl implements RewardsGalleryApiDatasource {
  @override
  Future<RewardsGalleryList> getGalleryRewards({Map<String, dynamic>? queryParameters}) async {
    RewardsGalleryList rewardsGalleryList = await ApiRequest<RewardsGalleryList>().request(
      method: HttpMethodRequest.getMethode,
      url: ApiEndPoints.getGalleryRewards,
      body: {},
      queryParameters: queryParameters,
      fromJson: RewardsGalleryListModel.fromJson,
    );
    return rewardsGalleryList;
  }

  @override
  Future<dynamic> redeemReward({required Map<String, dynamic> body}) async {
    dynamic dynamicModel = await ApiRequest<dynamic>().request(
      method: HttpMethodRequest.postMethode,
      url: ApiEndPoints.redeemReward,
      body: body,
      authorized: true,
      fromJson: getDynamic,
    );
    return dynamicModel;
  }
}
