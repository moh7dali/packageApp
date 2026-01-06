import 'package:my_custom_widget/features/address/domain/usecases/delete_customer_address.dart';
import 'package:my_custom_widget/shared/helper/shared_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/constants/constants.dart';
import '../../../../injection_container.dart';
import '../../../../shared/helper/location_helper.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../../../shared/widgets/shake_widget.dart';
import '../../../auth/domain/entities/area.dart';
import '../../../auth/domain/entities/city.dart';
import '../../../order_method/presentation/getx/selected_order_method_controller.dart';
import '../../domain/entity/address.dart';
import '../../domain/usecases/add_new_customer_address.dart';
import '../../domain/usecases/get_customer_addresses.dart';

class AddressController extends GetxController {
  final AddNewCustomerAddress addNewCustomerAddress;
  final GetCustomerAddresses getCustomerAddresses;
  final DeleteCustomerAddress deleteCustomerAddress;
  bool isOrder = false;

  AddressController() : addNewCustomerAddress = sl(), getCustomerAddresses = sl(), deleteCustomerAddress = sl();

  late GoogleMapController _controller;
  bool compassEnabled = true;
  bool mapToolbarEnabled = true;
  CameraTargetBounds cameraTargetBounds = CameraTargetBounds.unbounded;
  MinMaxZoomPreference minMaxZoomPreference = MinMaxZoomPreference.unbounded;
  MapType mapType = MapType.normal;
  bool rotateGesturesEnabled = true;
  bool scrollGesturesEnabled = true;
  bool tiltGesturesEnabled = true;
  bool zoomControlsEnabled = false;
  bool zoomGesturesEnabled = true;
  bool indoorViewEnabled = true;
  bool myLocationEnabled = true;
  bool myTrafficEnabled = false;
  bool myLocationButtonEnabled = false;
  LatLng currentLocation = const LatLng(31.996499, 35.848011);
  LatLng selectedPosition = const LatLng(31.996499, 35.848011);
  String addressDetails = 'selectYourAddress'.tr;

  final addressFormKey = GlobalKey<FormState>();
  final addressLabelShakeKey = GlobalKey<ShakeWidgetState>();
  final addressLabelController = TextEditingController();
  final nameShakeKey = GlobalKey<ShakeWidgetState>();
  final nameController = TextEditingController();
  final addressShakeKey = GlobalKey<ShakeWidgetState>();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final cityShakeKey = GlobalKey<ShakeWidgetState>();
  final areaController = TextEditingController();
  final areaShakeKey = GlobalKey<ShakeWidgetState>();
  final buildingNumberController = TextEditingController();
  final buildingNumberShakeKey = GlobalKey<ShakeWidgetState>();
  final floorNumberController = TextEditingController();
  final floorNumberShakeKey = GlobalKey<ShakeWidgetState>();

  String selectedAddressType = "home";
  bool isTheCupertinoPickerMove = false;
  City? selectedCity;
  Area? selectedArea;

  List<Address> customerAddresses = [];
  bool isLoading = true;

  Future<void> onMapCreated(GoogleMapController controller) async {
    _controller = controller;
    SharedHelper().scaleDialog(const LoadingWidget(), dismissible: false);
    await LocationHelper.requestLocationPermission((pos) async {
      currentLocation = LatLng(pos.latitude, pos.longitude);
      _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(pos.latitude, pos.longitude), zoom: 15)));
      if (Get.isOverlaysOpen) {
        Get.back();
      }
    });
  }

  reCenterCamera() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: currentLocation, zoom: 14)));
  }

  getLocationName() async {
    List<String> placeList = [];

    await placemarkFromCoordinates(selectedPosition.latitude, selectedPosition.longitude).then((value) {
      if (value.first.locality != null && value.first.locality!.length > 1) {
        placeList.add(value.first.locality!);
      }
      if (value.first.subLocality != null && value.first.subLocality!.length > 1) {
        placeList.add(value.first.subLocality!);
      }
      if (value.first.name != null) {
        placeList.add(value.first.name!);
      }
      addressDetails = placeList.join(',');
      update();
    });
  }

  void selectType(String value) {
    selectedAddressType = value;
    update();
  }

  addNewAddress() async {
    var body = {
      "Address": nameController.text,
      "Latitude": currentLocation.latitude,
      "Longitude": currentLocation.longitude,
      "CityId": selectedCity!.id,
      "AreaId": selectedArea!.id,
    };
    if (selectedAddressType == "other") {
      body.putIfAbsent("Name", () => addressLabelController.text);
    } else {
      body.putIfAbsent("Name", () => selectedAddressType);
    }
    if (buildingNumberController.text.isNotEmpty) {
      body.putIfAbsent("BuildingNumber", () => buildingNumberController.text);
    }
    if (floorNumberController.text.isNotEmpty) {
      body.putIfAbsent("Floor", () => floorNumberController.text);
    }
    SharedHelper().scaleDialog(const LoadingWidget(), dismissible: false);
    await addNewCustomerAddress.repository
        .addNewCustomerAddress(body: body)
        .then(
          (value) => value.fold(
            (failure) {
              SharedHelper().closeAllDialogs();
              SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
            },
            (done) {
              SharedHelper().closeAllDialogs();
              resetValues();
              if (isOrder) {
                Get.back();
                Get.back();
                final selectedOrderMethodController = Get.find<SelectedOrderMethodController>();
                selectedOrderMethodController.getCustomerAddressesApi();
              } else {
                Get.until((route) => route.settings.name == RouteConstant.myAddressPage);
                getCustomerAddressesApi();
              }
            },
          ),
        );
  }

  resetValues() {
    addressLabelController.clear();
    nameController.clear();
    cityController.clear();
    areaController.clear();
    buildingNumberController.clear();
    floorNumberController.clear();
    selectedAddressType = "home";
    selectedCity = null;
    selectedArea = null;
  }

  getCustomerAddressesApi() async {
    isLoading = true;
    update();
    await getCustomerAddresses.repository.getCustomerAddresses().then(
      (value) => value.fold(
        (failure) {
          SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
          isLoading = false;
          update();
        },
        (done) {
          customerAddresses = done.addresses ?? [];
          isLoading = false;
          update();
        },
      ),
    );
  }

  deleteAddress({required int id}) async {
    var body = {"id": "$id"};
    SharedHelper().scaleDialog(const LoadingWidget(), dismissible: false);
    await deleteCustomerAddress.repository
        .deleteCustomerAddress(body: body)
        .then(
          (value) => value.fold(
            (failure) {
              SharedHelper().closeAllDialogs();
              SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
            },
            (done) {
              customerAddresses.removeWhere((element) => element.id == id);
              update();
              SharedHelper().closeAllDialogs();
            },
          ),
        );
  }

  @override
  void onInit() {
    getCustomerAddressesApi();
    super.onInit();
  }
}
