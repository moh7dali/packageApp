import 'package:equatable/equatable.dart';

import 'campaign_details.dart';

class CampaignList extends Equatable {
  final List<CampaignDetails>? campaignList;
  final int? totalNumberOfResult;

  const CampaignList({required this.campaignList, required this.totalNumberOfResult});

  @override
  List<Object?> get props => [campaignList, totalNumberOfResult];
}
