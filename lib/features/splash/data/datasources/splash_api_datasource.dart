import 'dart:io';

import 'package:my_custom_widget/core/api/api_end_points.dart';
import 'package:my_custom_widget/core/api/api_request.dart';
import 'package:my_custom_widget/core/constants/constants.dart';
import 'package:my_custom_widget/features/splash/data/models/advertising_model.dart';
import 'package:my_custom_widget/features/splash/data/models/application_version_model.dart';

import '../../domain/entities/advertising_list.dart';

abstract class SplashApiDataSource {
  Future<ApplicationVersionModel> getApplicationVersionApi(String? buildNumber);

  Future<AdvertisingList> getAdvertisingApi({required Map<String, dynamic> queryParameters});
}

class SplashApiDataSourceImpl implements SplashApiDataSource {
  @override
  Future<AdvertisingList> getAdvertisingApi({required Map<String, dynamic> queryParameters}) async {
    AdvertisingList advertisingList = await ApiRequest<AdvertisingList>().request(
      method: HttpMethodRequest.getMethode,
      url: ApiEndPoints.getAdvertisingDetails,
      body: {},
      queryParameters: queryParameters,
      fromJson: AdvertisingListModel.fromJson,
    );
    return advertisingList;
  }

  @override
  Future<ApplicationVersionModel> getApplicationVersionApi(String? buildNumber) async {
    ApplicationVersionModel applicationVersion = await ApiRequest<ApplicationVersionModel>().request(
      method: HttpMethodRequest.getMethode,
      url: ApiEndPoints.getApplicationVersion,
      body: {},
      queryParameters: {
        "applicationId": "${AppConstants.applicationId}",
        "platformId": "${Platform.isAndroid ? 2 : 1}",
        "version": buildNumber,
      },
      fromJson: ApplicationVersionModel.fromJson,
    );
    return applicationVersion;
  }
}
