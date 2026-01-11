import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:my_custom_widget/features/rewards_gallery/data/datasource/rewards_gallery_api_datasource.dart';
import 'package:my_custom_widget/features/rewards_gallery/data/repositories/rewads_gallery_repository_impl.dart';
import 'package:my_custom_widget/features/rewards_gallery/domain/repositories/rewards_gallery_repository.dart';
import 'package:my_custom_widget/features/rewards_gallery/domain/usecase/get_rewards_gallery.dart';
import 'package:my_custom_widget/features/rewards_gallery/domain/usecase/redeem_reward.dart';
import 'package:my_custom_widget/features/topup/data/datasources/top_up_datasource.dart';
import 'package:my_custom_widget/features/topup/data/repositories/top_up_repository_impl.dart';
import 'package:my_custom_widget/features/topup/domain/repositories/top_up_repository.dart';
import 'package:my_custom_widget/features/topup/domain/usecases/get_customer_wallet_history.dart';
import 'package:my_custom_widget/features/topup/domain/usecases/get_top_up.dart';
import 'package:my_custom_widget/features/topup/domain/usecases/purchase_top_up.dart';
import 'package:my_custom_widget/shared/getx/theme_controller.dart';
import 'package:my_custom_widget/shared/helper/shared_preferences_storage.dart';

import 'core/utils/network_info.dart';
import 'features/auth/data/datasources/auth_api_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/add_referral.dart';
import 'features/auth/domain/usecases/get_area.dart';
import 'features/auth/domain/usecases/get_cities.dart';
import 'features/auth/domain/usecases/get_countries.dart';
import 'features/auth/domain/usecases/get_lookups.dart';
import 'features/auth/domain/usecases/post_check_validation_code.dart';
import 'features/auth/domain/usecases/post_complete_profile.dart';
import 'features/auth/domain/usecases/post_verify_mobile_number.dart';
import 'features/auth/domain/usecases/resend_verification_code.dart';
import 'features/barcode/data/datasources/user_barcode_api_datasource.dart';
import 'features/barcode/data/repositories/user_barcode_repository_impl.dart';
import 'features/barcode/domain/repositories/user_barcode_repository.dart';
import 'features/barcode/domain/usecases/get_uaer_barcode.dart';
import 'features/branch/data/datasources/branch_api_datasource.dart';
import 'features/branch/data/repositories/branch_repository_impl.dart';
import 'features/branch/domain/repositories/branch_repository.dart';
import 'features/branch/domain/usecases/check_in_customer.dart';
import 'features/branch/domain/usecases/get_branch_details.dart';
import 'features/branch/domain/usecases/get_closest_branches.dart';
import 'features/home/data/datasources/home_api_datasorce.dart';
import 'features/home/data/repositories/home_repository_impl.dart';
import 'features/home/domain/repositories/home_repository.dart';
import 'features/home/domain/usecases/get_customer_home_contents.dart';
import 'features/home/domain/usecases/get_home_details.dart';
import 'features/loyalty/data/datasources/loyalty_api_datasource.dart';
import 'features/loyalty/data/repositories/loyalty_repository_impl.dart';
import 'features/loyalty/domain/repositories/loyalty_repository.dart';
import 'features/loyalty/domain/usecase/get_tiers_loyalty_data.dart';
import 'features/loyalty/domain/usecase/get_tiers_loyalty_data_by_business_unit.dart';
import 'features/loyalty/domain/usecase/get_user_balance_history.dart';
import 'features/loyalty/domain/usecase/get_user_loyalty_data.dart';
import 'features/menu/data/datasources/menu_api_datasource.dart';
import 'features/menu/data/repositories/menu_repository_impl.dart';
import 'features/menu/domain/repositories/menu_repository.dart';
import 'features/menu/domain/usecases/delete_account.dart';
import 'features/menu/domain/usecases/get_merchant_info.dart';
import 'features/menu/domain/usecases/get_profile_info.dart';
import 'features/menu/domain/usecases/get_system_resource.dart';
import 'features/menu/domain/usecases/logout.dart';
import 'features/rewards/data/datasoursces/rewards_api_datasourse.dart';
import 'features/rewards/data/repositories/rewards_repository_impl.dart';
import 'features/rewards/domain/repositories/rewards_repository.dart';
import 'features/rewards/domain/usecase/get_campaign_list.dart';
import 'features/rewards/domain/usecase/get_campaign_rewards.dart';
import 'features/rewards/domain/usecase/get_user_rewards.dart';
import 'features/splash/data/datasources/splash_api_datasource.dart';
import 'features/splash/data/repositories/splash_repository_impl.dart';
import 'features/splash/domain/repositories/splash_repository.dart';
import 'features/splash/domain/usecases/get_advertising.dart';
import 'features/splash/domain/usecases/get_application_version.dart';

final sl = GetIt.instance;
bool _isDiInitialized = false;

Future<void> init() async {
  if (_isDiInitialized) return;
  _isDiInitialized = true;
  //Shared Preferences
  await SharedPreferencesStorage.init();
  sl.registerLazySingleton<SharedPreferencesStorage>(() => SharedPreferencesStorage());

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  sl.registerLazySingleton<InternetConnectionChecker>(() => InternetConnectionChecker());

  ///*************************///
  ///USECASES
  ///*************************///

  ///Splash
  sl.registerLazySingleton(() => GetApplicationVersion(sl()));
  sl.registerLazySingleton(() => GetAdvertising(sl()));

  ///Auth
  sl.registerLazySingleton(() => PostVerifyMobileNumber(sl()));
  sl.registerLazySingleton(() => PostCheckValidationCode(sl()));
  sl.registerLazySingleton(() => PostCompleteProfile(sl()));
  sl.registerLazySingleton(() => ResendVerificationCode(sl()));
  sl.registerLazySingleton(() => GetCities(sl()));
  sl.registerLazySingleton(() => GetArea(sl()));
  sl.registerLazySingleton(() => AddReferral(sl()));
  sl.registerLazySingleton(() => GetCountries(sl()));
  sl.registerLazySingleton(() => GetLookups(sl()));

  ///MENU
  sl.registerLazySingleton(() => GetProfileInfo(sl()));
  sl.registerLazySingleton(() => GetSystemResource(sl()));
  sl.registerLazySingleton(() => GetMerchantContactInfo(sl()));
  sl.registerLazySingleton(() => DeleteAccount(sl()));
  sl.registerLazySingleton(() => Logout(sl()));

  ///Home
  sl.registerLazySingleton(() => GetHomeDetails(sl()));
  sl.registerLazySingleton(() => GetCustomerHomeContents(sl()));

  ///Branch
  sl.registerLazySingleton(() => GetBranchDetails(sl()));
  sl.registerLazySingleton(() => GetClosestBranches(sl()));
  sl.registerLazySingleton(() => CheckInCustomer(sl()));

  ///Loyalty
  sl.registerLazySingleton(() => GetUserBalanceHistory(sl()));
  sl.registerLazySingleton(() => GetUserLoyaltyData(sl()));
  sl.registerLazySingleton(() => GetTiersLoyaltyData(sl()));
  sl.registerLazySingleton(() => GetTiersLoyaltyDataByBusinessUnit(sl()));

  ///Rewards
  sl.registerLazySingleton(() => GetUserRewards(sl()));
  sl.registerLazySingleton(() => GetCampaignList(sl()));
  sl.registerLazySingleton(() => GetCampaignRewards(sl()));

  ///Rewards Gallery
  sl.registerLazySingleton(() => GetGalleryRewards(sl()));
  sl.registerLazySingleton(() => RedeemReward(sl()));


  ///User Barcode
  sl.registerLazySingleton(() => GetUserBarcode(sl()));

  ///Top Up
  sl.registerLazySingleton(() => GetTopUp(sl()));
  sl.registerLazySingleton(() => PurchaseTopUp(sl()));
  sl.registerLazySingleton(() => GetCustomerWalletHistory(sl()));

  ///*************************///
  ///REPOSITORIES
  ///*************************///
  sl.registerLazySingleton<SplashRepository>(() => SplashRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<AuthRepositories>(() => AuthRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<MenuRepositories>(() => MenuRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<BranchRepository>(() => BranchRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<LoyaltyRepository>(() => LoyaltyRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<RewardsRepository>(() => RewardsRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<RewardsGalleryRepository>(() => RewardsGalleryRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<UserBarcodeRepository>(() => UserBarcodeRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<TopUpRepository>(() => TopUpRepositoryImpl(remoteDataSource: sl()));

  ///*************************///
  ///DATASOURCES
  ///*************************///
  sl.registerLazySingleton<SplashApiDataSource>(() => SplashApiDataSourceImpl());
  sl.registerLazySingleton<AuthApiDataSource>(() => AuthApiDataSourceImpl());
  sl.registerLazySingleton<MenuApiDataSource>(() => MenuApiDataSourceImpl());
  sl.registerLazySingleton<BranchApiDataSource>(() => BranchApiDataSourceImpl());
  sl.registerLazySingleton<HomeApiDataSource>(() => HomeApiDataSourceImpl());
  sl.registerLazySingleton<RewardsApiDataSource>(() => RewardsApiDataSourceImpl());
  sl.registerLazySingleton<RewardsGalleryApiDatasource>(() => RewardsGalleryApiDatasourceImpl());
  sl.registerLazySingleton<LoyaltyApiDataSource>(() => LoyaltyApiDataSourceImpl());
  sl.registerLazySingleton<UserBarCodeApiDataSource>(() => UserBarCodeApiDataSourceImpl());
  sl.registerLazySingleton<TopUpApiDataSource>(() => TopUpApiDataSourceImpl());
}
