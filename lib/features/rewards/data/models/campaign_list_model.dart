import 'package:mozaic_loyalty_sdk/features/rewards/domain/entity/campaign_details.dart';
import 'package:mozaic_loyalty_sdk/features/rewards/domain/entity/campaign_list.dart';

import 'campaign_details_model.dart';

class CampaignListModel extends CampaignList {
  const CampaignListModel({required super.campaignList, required super.totalNumberOfResult});

  factory CampaignListModel.fromJson(Map<String, dynamic> json) => CampaignListModel(
      campaignList:
          json["CampaignList"] == null ? [] : List<CampaignDetails>.from(json["CampaignList"]!.map((x) => CampaignDetailsModel.fromJson(x))),
      totalNumberOfResult: json['TotalNumberofResult']);

  Map<String, dynamic> toMap() => {"CampaignList": campaignList, "TotalNumberofResult": totalNumberOfResult};
}
