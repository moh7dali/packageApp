class ApiEndPoints {
  static const production = "https://webapi.mozaicloyaltyclub.com/";
  static const staging = "https://retailclubstaging.lazordclub.com/RetailClub.WebAPI/";
  static const dev = "https://development.lazordclub.com/RetailClub.WebAPI/";
  static const apiLink = "${staging}api/";

  /// Ends points
  ///*************************///
  ///
  /// splash
  static const String getApplicationVersion = '${apiLink}Common/GetApplicationVersion';
  static const String getAdvertisingDetails = '${apiLink}Advertising/GetAdvertisingDetails';

  /// auth
  static const String verifyMobileNumber = '${apiLink}Profile/VerifyMobileNumber';
  static const String resendVerificationCode = '${apiLink}Profile/ResendVerificationCode';
  static const String checkValidationCode = '${apiLink}Profile/CheckValidationCode';
  static const String completeProfile = '${apiLink}Profile/CompleteProfile';
  static const String getCities = '${apiLink}Common/GetCities';
  static const String getAreas = '${apiLink}Area/GetAreasByCityId';
  static const String addReferral = '${apiLink}Profile/AddReferral';
  static const String getCountries = '${apiLink}Country/GetCountries';
  static const String getLookupCategoryValues = '${apiLink}Common/GetLookupCategoryValues';

  ///brand
  static const String getBrandDetails = '${apiLink}Brand/GetBrandDetails';
  static const String getAllBrands = '${apiLink}Brand/GetAllBrands';

  ///branch
  static const String getBrandBranches = '${apiLink}Branch/GetBrandBranches';
  static const String getBranchDetails = '${apiLink}Branch/GetBranchDetails';
  static const String getClosestBranches = '${apiLink}Branch/GetClosestBranches';
  static const String getClosestBranch = '${apiLink}Branch/GetClosestBranch';
  static const String checkInCustomer = '${apiLink}UserLoyalty/CheckInCustomer';

  ///API Request
  static const String login = '${apiLink}Profile/RefreshCustomerToken';

  ///shared
  static const String changeDeviceLanguage = '${apiLink}Profile/ChangeDeviceLanguage';

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

  ///notification
  static const String getNumberOfNotifications = '${apiLink}Notification/GetNumberOfUnreadNotifications';
  static const String changeNotificationsReadStatus = '${apiLink}Notification/ChangeNotificationsReadStatus';
  static const String getNotifications = '${apiLink}Notification/GetCustomerNotifications';

  ///rate
  static const String rateBranchVisit = '${apiLink}Branch/RateBranchVisit';

  ///rewards
  static const String getCampaignList = '${apiLink}Campaign/GetCampaignList';
  static const String getUserRewards = '${apiLink}Reward/GetUserRewards';
  static const String getCampaignRewards = '${apiLink}Campaign/GetCampaignRewards';

  ///Category
  static const String getBrandCategories = '${apiLink}Category/GetBrandCategories';
  static const String getCategorySubCategories = '${apiLink}Category/GetCategorySubCategories';
  static const String getCategoryFilters = '${apiLink}Category/GetCategoryFilters';

  ///Product
  static const String getProductDetails = '${apiLink}Product/GetProductDetails';
  static const String getCategoryProducts = '${apiLink}Product/GetCategoryProducts';

  ///Rewards Gallery
  static const String getGalleryRewards = '${apiLink}Reward/GetGalleryRewards';
  static const String redeemReward = '${apiLink}Reward/RedeemReward';

  ///Customer Address
  static const String addNewCustomerAddress = '${apiLink}CustomerAddress/AddNewCustomerAddress';
  static const String deleteCustomerAddress = '${apiLink}CustomerAddress/DeleteCustomerAddress';
  static const String getCustomerAddresses = '${apiLink}CustomerAddress/GetCustomerAddresses';

  ///Ordering
  static const String getOrderCheckoutData = '${apiLink}Order/GetOrderCheckoutData';
  static const String createOrder = '${apiLink}Order/CreateOrder';
  static const String getCustomerOrder = '${apiLink}Order/GetCustomerOrders';
  static const String getOrderDetails = '${apiLink}Order/GetOrderDetails';
  static const String checkOrderingStatus = '${apiLink}Order/CheckOrderingStatus';

  ///Payment
  static const String checkOrderPaymentStatus = '${apiLink}Payment/CheckOrderPaymentStatus';
  static const String cancelOrderPayment = '${apiLink}Payment/CancelOrderPayment';
  static const String logPaymentFailure = '${apiLink}Payment/LogPaymentFailure';

  ///Offers
  static const String getOffers = '${apiLink}Offer/GetOffers';

  ///TopUp
  static const String getTopUp = '${apiLink}TopUp/GetTopUpItems';
  static const String purchase = '${apiLink}TopUp/Purchase';
  static const String getCustomerWalletHistory = '${apiLink}TopUp/GetCustomerWalletHistory';

  ///*************************///

  ///unUsed APIs
  static const String getLoyaltyProviders = '${apiLink}UserLoyalty/GetLoyaltyProviders';
  static const String getBusinessUnitBrands = '${apiLink}Brand/GetBusinessUnitBrands';
  static const String updateCustomerLastSeenDate = '${apiLink}Profile/UpdateCustomerLastSeenDate';
  static const String getAllMalls = '${apiLink}Mall/GetAllMalls';
  static const String getTiersLoyaltyDataByBusinessUnit = '${apiLink}UserLoyalty/GetTiersLoyaltyDataByBusinessUnit';
  static const String getMallDetails = '${apiLink}Mall/GetMallDetails';
  static const String getMallNavigationData = '${apiLink}Mall/GetMallNavigationData';
}
