import 'dart:convert';

import 'package:my_custom_widget/core/api/request_logger.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../injection_container.dart';
import '../../my_custom_widget.dart';
import '../../shared/helper/shared_helper.dart';
import '../../shared/helper/shared_preferences_storage.dart';
import '../../shared/model/login_model.dart';
import '../constants/constants.dart';
import '../error/exceptions.dart';
import '../utils/app_log.dart';
import 'api_end_points.dart';
import 'api_response.dart';
import 'header_interceptor.dart';

class ApiRequest<T> {
  Future<T> request({
    required String method,
    required String url,
    required Map<String, dynamic> body,
    required Function fromJson,
    bool authorized = false,
    bool isTemp = false,
    bool fromLogin = false,
    bool isNull = false,
    Map<String, String>? headerLogin,
    Map<String, dynamic>? queryParameters,
  }) async {
    if (await networkInfo!.isConnected) {
      final header = headerLogin ?? await _getHeaders(authorized, isTemp, fromLogin);
      final uri = Uri.parse(url).replace(queryParameters: queryParameters);
      final request = http.Request(method, uri)..headers.addAll(header);

      if (body.isNotEmpty) request.body = json.encode(body);

      final apiTAG = request.url.path.split("/").last;
      APILogger(apiTAG, request: request);

      final streamResponse = await request.send();
      final response = await http.Response.fromStream(streamResponse);
      APILogger(apiTAG, response: response);

      return _handleResponse(response, fromJson, isTemp, fromLogin, authorized, isNull, method, url, body, queryParameters);
    } else {
      return await SharedHelper().noInternetDialog(request: () async {
        return this.request(
            method: method,
            url: url,
            body: body,
            fromJson: fromJson,
            isTemp: isTemp,
            authorized: authorized,
            fromLogin: fromLogin,
            queryParameters: queryParameters,
            isNull: isNull);
      });
    }
  }

  Future<String?> loginApi() async {
    final header = await _getHeaders(false, false, true);
    final uri = Uri.parse(ApiEndPoints.login);
    final request = http.Request(HttpMethodRequest.getMethode, uri)..headers.addAll(header);

    final apiTAG = request.url.path.split("/").last;
    appLog(request.url, tag: "Request - Url {{ $apiTAG }}");
    appLog(json.encode(header), tag: "Request - Headers {{ $apiTAG }}");

    final streamResponse = await http.Client().send(request);
    final response = await http.Response.fromStream(streamResponse);

    appLog(response.statusCode, tag: "Response - StatusCode {{ $apiTAG }}");
    appLog(response.body, tag: "Response - Body {{ $apiTAG }}");

    if (response.statusCode == 200) {
      final loginData = LoginModel.fromJson(json.decode(response.body)["Data"]);
      if (json.decode(response.body)["IsSucceeded"] == true) {
        await sl<SharedPreferencesStorage>().setAccessToken(loginData.accessToken!);
        return loginData.accessToken;
      }
    } else {
      sl<SharedPreferencesStorage>().deleteAllData();
      Get.deleteAll();
      Get.offAllNamed(RouteConstant.authPage);
      SharedHelper().errorSnackBar("unauthorized".tr);
    }
    return null;
  }

  Future<Map<String, String>> _getHeaders(bool authorized, bool isTemp, bool fromLogin) async {
    return await HeaderInterceptor.getHeaders(isAuthorized: authorized, isTemp: isTemp, fromLogin: fromLogin);
  }

  Future<T> _handleResponse(
      http.Response response,
      Function fromJson,
      bool isTemp,
      bool fromLogin,
      bool authorized,
      bool isNull,
      String method,
      String url,
      Map<String, dynamic> body,
      Map<String, dynamic>? queryParameters,
      ) async {
    if (response.statusCode == 200) {
      final apiResponse = ApiResponse.fromJson(json.decode(response.body), fromJson);
      if ((apiResponse.isSucceeded ?? false) && (apiResponse.errors ?? []).isEmpty) {
        return apiResponse.data;
      }
      throw ApiErrorsException(
        errorCode: apiResponse.errors?.first.errorCode ?? "-1",
        errorMessage: apiResponse.errors?.first.errorMessage ?? "somethingWrong".tr,
      );
    }

    if (response.statusCode == 401) {
      if (isTemp) {
        Get.back();
        SharedHelper().closeAllDialogs();
        SharedHelper().errorSnackBar("unauthorized".tr);
      } else if (fromLogin) {
        sl<SharedPreferencesStorage>().deleteAllData();
        Get.offAllNamed(RouteConstant.authPage);
        SharedHelper().closeAllDialogs();
        SharedHelper().errorSnackBar("unauthorized".tr);
      } else {
        final nextToken = await loginApi();
        if (nextToken != null) {
          final headerNew = await _getHeaders(authorized, isTemp, fromLogin);
          return await request(
            method: method,
            url: url,
            body: body,
            fromJson: fromJson,
            isTemp: isTemp,
            authorized: authorized,
            fromLogin: true,
            headerLogin: headerNew,
            queryParameters: queryParameters,
          );
        }
      }
      throw ApiErrorsException(errorCode: "${response.statusCode}", errorMessage: "unauthorized".tr);
    }

    if (response.statusCode == 503 || response.statusCode == 408) {
      SharedHelper().closeAllDialogs();
      return await SharedHelper().serverErrorDialog(request: () async {
        return request(
          method: method,
          url: url,
          body: body,
          fromJson: fromJson,
          isTemp: isTemp,
          authorized: authorized,
          fromLogin: fromLogin,
          queryParameters: queryParameters,
        );
      });
    }

    throw ApiErrorsException(errorCode: "-1", errorMessage: "somethingWrong".tr);
  }

  Future<ApiResponse<T>> requestFullResponse({
    required String method,
    required String url,
    required Map<String, dynamic> body,
    required Function fromJson,
    bool authorized = false,
    bool isTemp = false,
    bool fromLogin = false,
    Map<String, String>? headerLogin,
    Map<String, dynamic>? queryParameters,
  }) async {
    if (await networkInfo!.isConnected) {
      final header = headerLogin ?? await _getHeaders(authorized, isTemp, fromLogin);
      final uri = Uri.parse(url).replace(queryParameters: queryParameters);
      final request = http.Request(method, uri)..headers.addAll(header);

      if (body.isNotEmpty) request.body = json.encode(body);

      final apiTAG = request.url.path.split("/").last;
      APILogger(apiTAG, request: request);

      final streamResponse = await request.send();
      final response = await http.Response.fromStream(streamResponse);
      APILogger(apiTAG, response: response);

      return _handleFullResponse(response, fromJson, isTemp, fromLogin, authorized, method, url, body, queryParameters);
    } else {
      return await SharedHelper().noInternetDialog(request: () async {
        return this.requestFullResponse(
          method: method,
          url: url,
          body: body,
          fromJson: fromJson,
          isTemp: isTemp,
          authorized: authorized,
          fromLogin: fromLogin,
          queryParameters: queryParameters,
        );
      });
    }
  }

  Future<ApiResponse<T>> _handleFullResponse(
      http.Response response,
      Function fromJson,
      bool isTemp,
      bool fromLogin,
      bool authorized,
      String method,
      String url,
      Map<String, dynamic> body,
      Map<String, dynamic>? queryParameters,
      ) async {
    if (response.statusCode == 200) {
      return ApiResponse<T>.fromJson(json.decode(response.body), fromJson);
    }

    if (response.statusCode == 401) {
      if (isTemp) {
        Get.back();
        SharedHelper().closeAllDialogs();
        SharedHelper().errorSnackBar("unauthorized".tr);
      } else if (fromLogin) {
        sl<SharedPreferencesStorage>().deleteAllData();
        Get.offAllNamed(RouteConstant.authPage);
        SharedHelper().closeAllDialogs();
        SharedHelper().errorSnackBar("unauthorized".tr);
      } else {
        final nextToken = await loginApi();
        if (nextToken != null) {
          final headerNew = await _getHeaders(authorized, isTemp, fromLogin);
          return await requestFullResponse(
            method: method,
            url: url,
            body: body,
            fromJson: fromJson,
            isTemp: isTemp,
            authorized: authorized,
            fromLogin: true,
            headerLogin: headerNew,
            queryParameters: queryParameters,
          );
        }
      }
      throw ApiErrorsException(errorCode: "${response.statusCode}", errorMessage: "unauthorized".tr);
    }

    if (response.statusCode == 503 || response.statusCode == 408) {
      SharedHelper().closeAllDialogs();
      return await SharedHelper().serverErrorDialog(request: () async {
        return requestFullResponse(
          method: method,
          url: url,
          body: body,
          fromJson: fromJson,
          isTemp: isTemp,
          authorized: authorized,
          fromLogin: fromLogin,
          queryParameters: queryParameters,
        );
      });
    }

    throw ApiErrorsException(errorCode: "-1", errorMessage: "somethingWrong".tr);
  }
}
