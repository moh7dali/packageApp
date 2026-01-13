import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/sdk/sdk_routes.dart';
import '../../../../injection_container.dart';
import '../../../../shared/helper/device_info.dart';
import '../../../../shared/helper/shared_helper.dart';
import '../../../../shared/helper/shared_preferences_storage.dart';
import '../../../../shared/model/pagination_list_model.dart';
import '../../../../shared/widgets/loading_button_widget/progress_button.dart';
import '../../../../shared/widgets/shake_widget.dart';
import '../../domain/entities/country.dart';
import '../../domain/entities/gender.dart';
import '../../domain/entities/marital_status.dart';
import '../../domain/usecases/get_countries.dart';
import '../../domain/usecases/post_check_validation_code.dart';
import '../../domain/usecases/post_complete_profile.dart';
import '../../domain/usecases/post_verify_mobile_number.dart';
import '../../domain/usecases/resend_verification_code.dart';

class AuthController extends GetxController with CodeAutoFill {
  final PostVerifyMobileNumber postVerifyMobileNumber;
  final PostCheckValidationCode postCheckValidationCode;
  final PostCompleteProfile postCompleteProfile;
  final ResendVerificationCode resendVerificationCode;
  final GetCountries getCountries;

  AuthController()
    : postVerifyMobileNumber = sl(),
      postCheckValidationCode = sl(),
      postCompleteProfile = sl(),
      resendVerificationCode = sl(),
      getCountries = sl();

  ButtonState btnState = ButtonState.normal;

  ///login && Verify
  String? otpCode;
  final loginFormKey = GlobalKey<FormState>();
  final verifyFormKey = GlobalKey<FormState>();
  final mobileShakeKey = GlobalKey<ShakeWidgetState>();
  final smsCodeShakeKey = GlobalKey<ShakeWidgetState>();
  StreamController<ErrorAnimationType> errorController = StreamController<ErrorAnimationType>();
  final mobileController = TextEditingController();
  final smsCodeController = TextEditingController();
  int numberOfDigit = 9;
  bool isResend = false;
  String smsDuration = '00';
  Timer? timer;
  String topText = "";
  String bottomText = "";
  String? errorText;

  ///Complete profile
  final editProfileFormKey = GlobalKey<FormState>();
  final fNameShakeKey = GlobalKey<ShakeWidgetState>();
  final lNameShakeKey = GlobalKey<ShakeWidgetState>();
  final bodShakeKey = GlobalKey<ShakeWidgetState>();
  final genderShakeKey = GlobalKey<ShakeWidgetState>();
  final referralShakeKey = GlobalKey<ShakeWidgetState>();
  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final bodController = TextEditingController();
  final genderController = TextEditingController();
  final dateFormat = DateFormat('yyyy-MM-dd');
  final dateUTCFormat = DateFormat('yyyy-MM-DD HH:MM:SS.SSS');

  bool isTheCupertinoPickerMove = false;

  Gender? selectedGenderType;
  DateTime? selectedDateOfBirth;

  ///Referral Screen
  final referralFormKey = GlobalKey<FormState>();
  final referralController = TextEditingController();

  ///  Countries
  Country selectedCountry = Country(name: "Saudi Arabia", id: 400, flag: '\uD83C\uDDF8\uD83C\uDDE6', callingCode: '+966', iso2: 'SA');
  final searchController = TextEditingController();
  List<Country> firstTimeHit = [];
  List<Country> countries = [];
  bool after = false;
  bool isLoadingCountries = false;

  void searchCountries(String value) {
    if (value.length >= 3) {
      after = false;
      refreshList();
      update();
    } else {
      after = true;
      refreshList();
      update();
    }
  }

  void refreshList() {
    isLoadingCountries = true;
    update();
    Future.delayed(Duration(milliseconds: 100), () {
      isLoadingCountries = false;
      update();
    });
  }

  Future<PaginationListModel> getCountriesAfter() async {
    after = false;
    return PaginationListModel(totalNumberOfResult: firstTimeHit.length + 1, listOfObjects: firstTimeHit);
  }

  Future<PaginationListModel> getCountriesList({int page = 1}) async {
    Map<String, dynamic> body = {"pageNumber": "$page"};
    if (searchController.text.length >= 3) {
      body.putIfAbsent("Name", () => searchController.text);
    }
    countries = [];
    after = false;
    int totalNumberOfResult = 0;
    await getCountries.repository
        .getCountries(body: body)
        .then(
          (value) => value.fold(
            (failure) {
              SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
            },
            (countryDetailsList) {
              List<Country> list = countryDetailsList.countries ?? [];
              countries = list;
              if (firstTimeHit.isEmpty) {
                firstTimeHit = countries;
              }
              totalNumberOfResult = countryDetailsList.totalNumberOfResult ?? 0;
              update();
            },
          ),
        );
    return PaginationListModel(totalNumberOfResult: totalNumberOfResult, listOfObjects: countries);
  }

  void selectCountry(Country country) {
    selectedCountry = country;
    sl<SharedPreferencesStorage>().setUserCountry(country);
    SharedHelper().closeAllDialogs();
    update();
  }

  @override
  void onInit() {
    selectCountry(selectedCountry);
    super.onInit();
  }

  Future<void> verifyMobileNumber() async {
    btnState = ButtonState.loading;
    update();
    Map<String, String> deviceInfo = await DeviceInfo.getDeviceData();
    var oneSignalToken = OneSignal.User.pushSubscription.id;
    deviceInfo["NotificationToken"] = "$oneSignalToken";
    String number = "";
    if (mobileController.text.startsWith("0")) {
      number = mobileController.text.replaceFirst("0", "");
    } else {
      number = mobileController.text;
    }
    await postVerifyMobileNumber.repository
        .postVerifyMobileNumber(
          body: {
            "CustomerData": {"MobileNumber": "${selectedCountry.callingCode}$number"},
            "UserDeviceData": deviceInfo,
          },
        )
        .then(
          (value) => value.fold(
            (failure) {
              btnState = ButtonState.fail;
              resetBtnState();
              SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
            },
            (verifyMobileNumber) {
              btnState = ButtonState.success;
              resetBtnState();
              Future.delayed(const Duration(seconds: 1), () async {
                sl<SharedPreferencesStorage>().setTempToken(verifyMobileNumber.token);
                smsCodeController.clear();
                errorController = StreamController<ErrorAnimationType>();
                SDKNav.toNamed(RouteConstant.verifyPage);
                startTimer();
                sl<SharedPreferencesStorage>().setMobile(number);
              });
            },
          ),
        );
    update();
  }

  Future<void> checkValidationCode() async {
    btnState = ButtonState.loading;
    update();
    await postCheckValidationCode.repository
        .postCheckValidationCode(body: {"verificationCode": smsCodeController.text})
        .then(
          (value) => value.fold(
            (failure) async {
              btnState = ButtonState.fail;
              update();
              await resetBtnState();
              smsCodeController.text = "";
              SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
            },
            (checkValidationCode) {
              btnState = ButtonState.success;
              sl<SharedPreferencesStorage>().setAccessToken(checkValidationCode.accessToken!);
              sl<SharedPreferencesStorage>().setSessionToken(checkValidationCode.sessionToken!);
              sl<SharedPreferencesStorage>().setIsCompleted(checkValidationCode.isCompleted!);
              sl<SharedPreferencesStorage>().setIsUserLoggedIn(true);
              resetBtnState();
              Future.delayed(const Duration(seconds: 1), () async {
                if (checkValidationCode.isCompleted == true) {
                  Get.deleteAll();
                  SDKNav.offAllNamed(RouteConstant.homeScreen);
                } else {
                  SDKNav.offAllNamed(RouteConstant.completeProfile);
                }
              });
            },
          ),
        );
  }

  Future<void> resendCode() async {
    btnState = ButtonState.loading;
    update();
    await resendVerificationCode.repository.resendVerificationCode().then(
      (value) => value.fold(
        (failure) async {
          btnState = ButtonState.fail;
          update();
          resetBtnState();
          SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
        },
        (resendCode) {
          resetBtnState();
          startTimer();
        },
      ),
    );
    update();
  }

  void startTimer() {
    listenForCode();
    getAppSignature();
    isResend = false;
    update();
    if (timer?.isActive ?? false) {
      timer?.cancel();
      smsDuration = '00';
    }
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      smsDuration = SharedHelper.getSecondDurationFormat(Duration(seconds: 60 - t.tick));
      if (t.tick == 59) {
        t.cancel();
        smsDuration = SharedHelper.getSecondDurationFormat(const Duration(seconds: 0));
      }
      update();
    });
  }

  Future<void> completeProfile() async {
    btnState = ButtonState.loading;
    update();
    var body = {
      "FirstName": fNameController.text,
      "LastName": lNameController.text,
      "Gender": selectedGenderType!.id,
      "BirthDate": selectedDateOfBirth!.toIso8601String(),
    };
    await postCompleteProfile.repository
        .postCompleteProfile(body: body)
        .then(
          (value) => value.fold(
            (failure) async {
              btnState = ButtonState.fail;
              update();
              await resetBtnState();
              SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
            },
            (completeProfile) async {
              btnState = ButtonState.success;
              update();
              sl<SharedPreferencesStorage>().setIsCompleted(true);
              await resetBtnState();
              Get.deleteAll();
              SDKNav.offAllNamed(RouteConstant.homeScreen);
            },
          ),
        );
  }

  Future resetBtnState() async {
    await Future.delayed(const Duration(milliseconds: 750), () {
      btnState = ButtonState.normal;
      update();
    });
  }

  void resetValues() {
    mobileController.clear();
    referralController.clear();
    smsCodeController.clear();
    fNameController.clear();
    lNameController.clear();
    bodController.clear();
    genderController.clear();
    selectedGenderType = null;
    isResend = false;
    smsDuration = '00';
    timer = null;
    topText = "";
    bottomText = "";
  }

  MaritalStatus? getMaritalState(int marital) {
    if (marital == 1) {
      return MaritalStatus(id: 1, name: "single".tr);
    } else if (marital == 2) {
      return MaritalStatus(id: 2, name: "married".tr);
    }
    return null;
  }

  Gender? getGender(int gender) {
    if (gender == 1) {
      return Gender(name: "male".tr, id: 1);
    } else if (gender == 2) {
      return Gender(name: "female".tr, id: 2);
    }
    return null;
  }

  @override
  void codeUpdated() {
    print("codeUpdated $code");
    otpCode = code;
    smsCodeController.text = otpCode!;
    update();
  }

  void getAppSignature() async {
    String appSignature = await SmsAutoFill().getAppSignature;
    print("App Signature: $appSignature");
  }

  Future<void> getDataAfterDelete() async {
    mobileController.text = (await sl<SharedPreferencesStorage>().getMobile() ?? "");
    startTimer();
  }
}
