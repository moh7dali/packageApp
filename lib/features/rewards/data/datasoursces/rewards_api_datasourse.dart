import 'package:mozaic_loyalty_sdk/features/rewards/data/models/campaign_rewards_model.dart';
import 'package:mozaic_loyalty_sdk/features/rewards/domain/entity/campaign_rewards.dart';

import '../../../../core/api/api_end_points.dart';
import '../../../../core/api/api_request.dart';
import '../../../../core/constants/constants.dart';
import '../../domain/entity/campaign_list.dart';
import '../../domain/entity/user_reward_list.dart';
import '../models/campaign_list_model.dart';
import '../models/user_rewards_list_model.dart';

abstract class RewardsApiDataSource {
  Future<UserRewardsList> getUserRewards({required Map<String, dynamic> body});

  Future<CampaignList> getCampaignList({required Map<String, dynamic> body});

  Future<CampaignRewards> getCampaignRewards({required Map<String, dynamic> body});
}

class RewardsApiDataSourceImpl implements RewardsApiDataSource {
  @override
  Future<CampaignList> getCampaignList({required Map<String, dynamic> body}) async {
    CampaignList campaignList = await ApiRequest<CampaignList>().request(
      method: HttpMethodRequest.postMethode,
      url: ApiEndPoints.getCampaignList,
      body: body,
      authorized: true,
      fromJson: CampaignListModel.fromJson,
    );
    return campaignList;
  }

  @override
  Future<UserRewardsList> getUserRewards({required Map<String, dynamic> body}) async {
    UserRewardsList? userRewardsList = await ApiRequest<UserRewardsList?>().request(
      method: HttpMethodRequest.getMethode,
      url: ApiEndPoints.getUserRewards,
      body: {},
      queryParameters: body,
      authorized: true,
      fromJson: UserRewardsListModel.fromJson,
    );
    return userRewardsList ?? const UserRewardsList(totalNumberOfResult: 0, userRewardsList: []);
  }

  @override
  Future<CampaignRewards> getCampaignRewards({required Map<String, dynamic> body}) async {
    CampaignRewards campaignRewards = await ApiRequest<CampaignRewards>().request(
      method: HttpMethodRequest.getMethode,
      url: ApiEndPoints.getCampaignRewards,
      queryParameters: body,
      body: {},
      authorized: true,
      fromJson: CampaignRewardsModel.fromJson,
    );
    return campaignRewards;
  }
}
