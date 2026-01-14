import 'package:mozaic_loyalty_sdk/features/auth/data/models/check_validation_code_model.dart';
import 'package:mozaic_loyalty_sdk/features/auth/domain/entities/check_validation_code.dart';

import '../../../../core/api/api_end_points.dart';
import '../../../../core/api/api_request.dart';
import '../../../../core/api/api_response.dart';
import '../../../../core/constants/constants.dart';
import '../../domain/entities/countries_list.dart';
import '../models/countries_list_model.dart';
import '../models/verify_mobile_number_model.dart';

abstract class AuthApiDataSource {
  Future<VerifyMobileNumberModel> postVerifyMobileNumber({required Map<String, dynamic> body});

  Future<CheckValidationCode> postCheckValidationCode({required Map<String, dynamic> body});

  Future<dynamic> postCompleteProfile({required Map<String, dynamic> body});

  Future<bool> resendVerificationCode();

  Future<CountriesList> getCountries({required Map<String, dynamic> body});
}

class AuthApiDataSourceImpl implements AuthApiDataSource {
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
  Future<CountriesList> getCountries({required Map<String, dynamic> body}) async {
    CountriesList countriesList = await ApiRequest<CountriesList>().request(
      method: HttpMethodRequest.postMethode,
      url: ApiEndPoints.getCountries,
      body: body,
      fromJson: CountriesListModel.fromJson,
    );
    return countriesList;
  }
}
