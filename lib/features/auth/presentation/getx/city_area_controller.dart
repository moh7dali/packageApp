import 'package:my_custom_widget/core/constants/constants.dart';
import 'package:my_custom_widget/core/utils/app_log.dart';
import 'package:my_custom_widget/features/auth/domain/usecases/get_area.dart';
import 'package:my_custom_widget/shared/helper/shared_helper.dart';
import 'package:get/get.dart';

import '../../../../injection_container.dart';
import '../../domain/entities/area.dart';
import '../../domain/entities/city.dart';
import '../../domain/usecases/get_cities.dart';

class CityAndAreaController extends GetxController {
  List<City>? allCities;
  List<Area>? allArea;
  final GetCities getCities;
  final GetArea getArea;
  bool isAreaLoading = true;
  bool isCityLoading = true;
  bool isProfile;

  CityAndAreaController({this.isProfile = false})
      : getCities = sl(),
        getArea = sl();

  @override
  void onInit() {
    appLog("Inside the CityAndAreaController");
    super.onInit();
    SharedHelper().isUserLoggedIn().then((value) {
      if (value) {
        appLog("Inside the CityAndAreaController isUserLoggedIn");
        if (!isProfile) {
          getCitiesList();
        } else {
          isCityLoading = false;
          update();
        }
        isAreaLoading = false;
        update();
      }
    });
  }

  getCitiesList() async {
    isCityLoading = true;
    update();
    await getCities.repository.getCities(body: {
      "countryId": "${AppConstants.countryId}",
      // "merchantId": "${AppConstants.merchantId}",
    }).then((value) => value.fold(
          (failure) {
            SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
            isCityLoading = false;
            update();
          },
          (cities) {
            allCities = cities;
            isCityLoading = false;
            update();
          },
        ));
    appLog("the list of cities is : $allCities");
    update;
  }

  getAreaList({required int cityId}) async {
    isAreaLoading = true;
    update();
    await getArea.repository.getArea(body: {
      "cityId": "$cityId",
      // "merchantId": "${AppConstants.merchantId}",
    }).then((value) => value.fold(
          (failure) {
            SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
            isAreaLoading = false;
            update();
          },
          (area) {
            allArea = area;
            isAreaLoading = false;
            update();
          },
        ));
    appLog("the list of area is : $allArea");
    update;
  }
}
