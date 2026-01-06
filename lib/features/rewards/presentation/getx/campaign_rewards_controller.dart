import 'package:get/get.dart';

import '../../../../core/utils/app_log.dart';
import '../../../../injection_container.dart';
import '../../../../shared/helper/shared_helper.dart';
import '../../domain/entity/campaign_details.dart';
import '../../domain/entity/campaign_rewards.dart';
import '../../domain/usecase/get_campaign_rewards.dart';

class CampaignRewardsController extends GetxController {
  final GetCampaignRewards getCampaignRewards;

  CampaignRewardsController({required this.selectedCampaignDetails}) : getCampaignRewards = sl();

  CampaignRewards? campaignRewards;
  bool isLoading = true;
  final CampaignDetails selectedCampaignDetails;

  @override
  void onInit() {
    getCampaignRewardsApi();
    super.onInit();
  }

  Future<void> getCampaignRewardsApi() async {
    getCampaignRewards.repository.getCampaignRewards(body: {"id": "${selectedCampaignDetails.id}"}).then(((value) => value.fold((failure) {
          isLoading = false;
          update();
          SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
        }, (val) {
          campaignRewards = val;
          isLoading = false;
          update();
          appLog(val, tag: "getCampaignRewardsApi");
        })));
  }
}
