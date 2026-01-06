import 'package:my_custom_widget/features/auth/data/models/check_validation_code_model.dart';
import 'package:my_custom_widget/features/auth/data/models/city_model.dart';
import 'package:my_custom_widget/features/auth/domain/entities/area.dart';
import 'package:my_custom_widget/features/auth/domain/entities/check_validation_code.dart';

import '../../../../core/api/api_end_points.dart';
import '../../../../core/api/api_request.dart';
import '../../../../core/api/api_response.dart';
import '../../../../core/constants/constants.dart';
import '../../domain/entities/city.dart';
import '../../domain/entities/countries_list.dart';
import '../../domain/entities/look_up.dart';
import '../models/area_model.dart';
import '../models/countries_list_model.dart';
import '../models/look_up_model.dart';
import '../models/verify_mobile_number_model.dart';

abstract class AuthApiDataSource {
  Future<VerifyMobileNumberModel> postVerifyMobileNumber({required Map<String, dynamic> body});

  Future<CheckValidationCode> postCheckValidationCode({required Map<String, dynamic> body});

  Future<dynamic> postCompleteProfile({required Map<String, dynamic> body});

  Future<bool> resendVerificationCode();

  Future<List<City>> getCities({required Map<String, dynamic> body});

  Future<List<Area>> getArea({required Map<String, dynamic> body});

  Future<dynamic> addReferral({required Map<String, dynamic> body});

  Future<CountriesList> getCountries({required Map<String, dynamic> body});

  Future<List<LookUp>> getLookUps({required Map<String, dynamic> body});
}

class AuthApiDataSourceImpl implements AuthApiDataSource {
  final bool isTest;

  AuthApiDataSourceImpl({this.isTest = false});

  @override
  Future<VerifyMobileNumberModel> postVerifyMobileNumber({required Map<String, dynamic> body}) async {
    VerifyMobileNumberModel verifyMobileNumber = await ApiRequest<VerifyMobileNumberModel>().request(
      method: HttpMethodRequest.postMethode,
      url: ApiEndPoints.verifyMobileNumber,
      body: body,
      fromJson: VerifyMobileNumberModel.fromJson,
    );
    return verifyMobileNumber;
  }

  @override
  Future<CheckValidationCodeModel> postCheckValidationCode({required Map<String, dynamic> body}) async {
    CheckValidationCodeModel checkValidationCodeModel = await ApiRequest<CheckValidationCodeModel>().request(
      method: HttpMethodRequest.postMethode,
      url: ApiEndPoints.checkValidationCode,
      body: {},
      queryParameters: body,
      isTemp: true,
      fromJson: CheckValidationCodeModel.fromJson,
    );
    return checkValidationCodeModel;
  }

  @override
  Future<bool> resendVerificationCode() async {
    bool? dynamicModel = await ApiRequest<bool?>().request(
      method: HttpMethodRequest.getMethode,
      url: ApiEndPoints.resendVerificationCode,
      body: {},
      isTemp: true,
      fromJson: getBool,
    );
    return dynamicModel ?? true;
  }

  @override
  Future<dynamic> postCompleteProfile({required Map<String, dynamic> body}) async {
    dynamic completeProfileModel = await ApiRequest<dynamic>().request(
      method: HttpMethodRequest.postMethode,
      url: ApiEndPoints.completeProfile,
      body: body,
      authorized: true,
      isNull: true,
      fromJson: getDynamic,
    );
    return completeProfileModel;
  }

  @override
  Future<List<City>> getCities({required Map<String, dynamic> body}) async {
    List<City>? cityListModel = await ApiRequest<List<City>?>().request(
      method: HttpMethodRequest.getMethode,
      url: ApiEndPoints.getCities,
      body: {},
      queryParameters: body,
      fromJson: countriesFromJson,
    );
    return cityListModel ?? [];
  }

  @override
  Future<List<Area>> getArea({required Map<String, dynamic> body}) async {
    List<Area>? areaList = await ApiRequest<List<Area>?>().request(
      method: HttpMethodRequest.getMethode,
      url: ApiEndPoints.getAreas,
      body: {},
      queryParameters: body,
      fromJson: areasFromJson,
    );
    return areaList ?? [];
  }

  @override
  Future addReferral({required Map<String, dynamic> body}) async {
    dynamic addReferralApi = await ApiRequest<dynamic>().request(
      method: HttpMethodRequest.postMethode,
      url: ApiEndPoints.addReferral,
      body: {},
      queryParameters: body,
      authorized: true,
      isNull: true,
      fromJson: getDynamic,
    );
    return addReferralApi;
  }

  Future<CountriesList> getCountries({required Map<String, dynamic> body}) async {
    CountriesList countriesList = await ApiRequest<CountriesList>().request(
      method: HttpMethodRequest.postMethode,
      url: ApiEndPoints.getCountries,
      body: body,
      fromJson: CountriesListModel.fromJson,
    );
    return countriesList;
  }
  Future<List<LookUp>> getLookUps({required Map<String, dynamic> body}) async {
    List<LookUp>? lookUpListModel = await ApiRequest<List<LookUp>?>().request(
      method: HttpMethodRequest.getMethode,
      url: ApiEndPoints.getLookupCategoryValues,
      body: {},
      queryParameters: body,
      fromJson: lookUpFromJson,
    );
    return lookUpListModel ?? [];
  }
}
