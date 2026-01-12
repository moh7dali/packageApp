class ApiEndPoints {
  static const production = "https://webapi.mozaicloyaltyclub.com/";
  static const staging = "https://retailclubstaging.lazordclub.com/RetailClub.WebAPI/";
  static const dev = "https://development.lazordclub.com/RetailClub.WebAPI/";
  static const apiLink = "${staging}api/";

  /// Ends points
  ///*************************///
  ///

  /// auth
  static const String verifyMobileNumber = '${apiLink}Profile/VerifyMobileNumber';
  static const String resendVerificationCode = '${apiLink}Profile/ResendVerificationCode';
  static const String checkValidationCode = '${apiLink}Profile/CheckValidationCode';
  static const String completeProfile = '${apiLink}Profile/CompleteProfile';
  static const String addReferral = '${apiLink}Profile/AddReferral';
  static const String getCountries = '${apiLink}Country/GetCountries';

  ///branch
  static const String getBranchDetails = '${apiLink}Branch/GetBranchDetails';
  static const String getClosestBranches = '${apiLink}Branch/GetClosestBranches';
  static const String checkInCustomer = '${apiLink}UserLoyalty/CheckInCustomer';

  ///API Request
  static const String login = '${apiLink}Profile/RefreshCustomerToken';

  ///Loyalty
  static const String getUserLoyaltyData = '${apiLink}UserLoyalty/GetUserLoyaltyData';
  static const String getTiersLoyaltyData = '${apiLink}UserLoyalty/GetTiersLoyaltyData';
  static const String getUserBalanceHistory = '${apiLink}UserLoyalty/GetUserBalanceHistory';

  ///home
  static const String getHomeContents = '${apiLink}Home/GetHomeContents';
  static const String getCustomerHomeContents = '${apiLink}Home/GetCustomerHomeContents';

  ///barcode
  static const String getBarcodeUserData = '${apiLink}UserLoyalty/GetBarcodeUserData';

  ///menus
  static const String getProfile = '${apiLink}Profile/GetProfileInfo';
  static const String getSystemResource = '${apiLink}Common/GetSystemResource';
  static const String getMerchantContactInfo = '${apiLink}Merchant/GetMerchantContactInfo';
  static const String deleteProfile = '${apiLink}Profile/DeleteProfile';
  static const String logout = '${apiLink}Profile/Logout';

  ///rewards
  static const String getCampaignList = '${apiLink}Campaign/GetCampaignList';
  static const String getUserRewards = '${apiLink}Reward/GetUserRewards';
  static const String getCampaignRewards = '${apiLink}Campaign/GetCampaignRewards';

  ///Rewards Gallery
  static const String getGalleryRewards = '${apiLink}Reward/GetGalleryRewards';
  static const String redeemReward = '${apiLink}Reward/RedeemReward';
}
