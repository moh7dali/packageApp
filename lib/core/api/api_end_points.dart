import '../../mozaic_loyalty_sdk.dart';
import '../sdk/sdk_settings.dart';

class ApiEndPoints {
  static final production = "https://webapi.mozaicloyaltyclub.com/";
  static final staging = "https://retailclubstaging.lazordclub.com/RetailClub.WebAPI/";

  static final apiLink = "${MozaicLoyaltySDK.settings.environmentType == EnvironmentType.test ? staging : production}api/";

  /// Ends points
  ///*************************///
  ///

  ///branch
  static final String getBranchDetails = '${apiLink}Branch/GetBranchDetails';
  static final String getClosestBranches = '${apiLink}Branch/GetClosestBranches';
  static final String checkInCustomer = '${apiLink}UserLoyalty/CheckInCustomer';

  ///API Request
  static final String login = '${apiLink}Profile/RefreshCustomerToken';

  ///Loyalty
  static final String getUserLoyaltyData = '${apiLink}UserLoyalty/GetUserLoyaltyData';
  static final String getTiersLoyaltyData = '${apiLink}UserLoyalty/GetTiersLoyaltyData';
  static final String getUserBalanceHistory = '${apiLink}UserLoyalty/GetUserBalanceHistory';

  ///home
  static final String getCustomerHomeContents = '${apiLink}Home/GetCustomerHomeContents';

  ///barcode
  static final String getBarcodeUserData = '${apiLink}UserLoyalty/GetBarcodeUserData';

  ///rewards
  static final String getCampaignList = '${apiLink}Campaign/GetCampaignList';
  static final String getUserRewards = '${apiLink}Reward/GetUserRewards';
  static final String getCampaignRewards = '${apiLink}Campaign/GetCampaignRewards';
}
