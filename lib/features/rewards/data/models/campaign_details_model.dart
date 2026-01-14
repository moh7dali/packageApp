import 'package:mozaic_loyalty_sdk/features/rewards/domain/entity/campaign_details.dart';

class CampaignDetailsModel extends CampaignDetails {
  const CampaignDetailsModel({
    required super.id,
    required super.name,
    required super.description,
    required super.toDate,
    required super.fromDate,
  });

  factory CampaignDetailsModel.fromJson(Map<String, dynamic> json) => CampaignDetailsModel(
        id: json['Id'],
        name: json['Name'],
        description: json['Description'],
        toDate: json['ToDate'],
        fromDate: json['FromDate'],
      );

  Map<String, dynamic> toMap() => {
        "Id": id,
        "Name": name,
        "Description": description,
        "ToDate": toDate,
        "FromDate": fromDate,
      };
}
