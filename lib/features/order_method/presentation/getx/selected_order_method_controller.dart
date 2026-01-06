import 'package:my_custom_widget/core/constants/constants.dart';
import 'package:my_custom_widget/features/address/domain/entity/address.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../injection_container.dart';
import '../../../../my_custom_widget.dart';
import '../../../../shared/helper/location_helper.dart';
import '../../../../shared/helper/shared_helper.dart';
import '../../../../shared/helper/shared_preferences_storage.dart';
import '../../../../shared/model/cart_items.dart';
import '../../../../shared/model/pagination_list_model.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../../address/domain/usecases/get_customer_addresses.dart';
import '../../../address/presentation/getx/address_controller.dart';
import '../../../branch/domain/entities/branch_details.dart';
import '../../../branch/domain/usecases/get_all_branches.dart';
import '../../../branch/domain/usecases/get_closest_branch.dart';

class SelectedOrderMethodController extends GetxController {
  final bool isPickUp;
  final void Function() onFinish;

  SelectedOrderMethodController({required this.onFinish, required this.isPickUp})
    : allBranches = sl(),
      getCustomerAddresses = sl(),
      getClosestBranch = sl();
  final GetAllBranches allBranches;
  final GetCustomerAddresses getCustomerAddresses;
  final GetClosestBranch getClosestBranch;

  final searchController = TextEditingController();
  List<BranchDetails> firstTimeHit = [];
  List<BranchDetails> branchList = [];
  bool after = false;
  bool isLoadingBranches = false;
  bool isLoadingAddress = true;
  BranchDetails? selectedBranch;
  Address? selectedAddress;
  List<Address> customerAddresses = [];
  LatLng selectedPosition = const LatLng(31.996499, 35.848011);

  void searchBranches(String value) {
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
    isLoadingBranches = true;
    update();
    Future.delayed(Duration(milliseconds: 100), () {
      isLoadingBranches = false;
      update();
    });
  }

  Future<PaginationListModel> getBranchesAfter() async {
    after = false;
    return PaginationListModel(totalNumberOfResult: firstTimeHit.length + 1, listOfObjects: firstTimeHit);
  }

  Future<PaginationListModel> getAllBranchesList({int page = 1}) async {
    await _ensureCustomerLocationReady();
    Map<String, dynamic> body = {"pageNumber": "$page", "SupportPickupOrdering": true, "brandId": "${AppConstants.brandId}"};
    if (_lat != null && _lng != null) {
      body.putIfAbsent("CustomerLocation", () => {"Latitude": _lat, "Longitude": _lng});
    }
    if (searchController.text.length >= 3) {
      body.putIfAbsent("Name", () => searchController.text);
    }
    branchList = [];
    after = false;
    int totalNumberOfResult = 0;
    await allBranches.repository
        .getAllBranches(body: body)
        .then(
          (value) => value.fold(
            (failure) {
              SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
              update();
            },
            (brandsDetailsList) {
              List<BranchDetails> list = brandsDetailsList.branches ?? [];
              branchList = list;
              if (firstTimeHit.isEmpty) {
                firstTimeHit = branchList;
              }
              totalNumberOfResult = brandsDetailsList.totalNumberofResult ?? 0;
              update();
            },
          ),
        );
    return PaginationListModel(totalNumberOfResult: totalNumberOfResult, listOfObjects: branchList);
  }

  getCustomerAddressesApi() async {
    final addressController = Get.isRegistered<AddressController>() ? Get.find<AddressController>() : Get.put(AddressController());
    addressController.isOrder = true;
    await addressController.getCustomerAddressesApi();
    customerAddresses = addressController.customerAddresses;
    isLoadingAddress = addressController.isLoading;
    update();
  }

  Future<void> selectBranch(BranchDetails branch) async {
    selectedBranch = branch;
    BranchDetails? oldBranch = await sl<SharedPreferencesStorage>().getSelectedBranch();
    if ((oldBranch == null || oldBranch.id == selectedBranch!.id) || cartItems.value.products.isEmpty) {
      await sl<SharedPreferencesStorage>().setSelectedBranch(selectedBranch!);
      await sl<SharedPreferencesStorage>().setIsPickUp(isPickUp);
      await sl<SharedPreferencesStorage>().setIsBranchSelected(true);
      SharedHelper().closeAllDialogs();
      onFinish();
      update();
    } else {
      SharedHelper().actionDialog(
        "ClearCartTitle".tr,
        "ClearCartBody".tr,
        confirm: () async {
          await sl<SharedPreferencesStorage>().setSelectedBranch(selectedBranch!);
          await sl<SharedPreferencesStorage>().setIsBranchSelected(true);
          await sl<SharedPreferencesStorage>().setIsPickUp(isPickUp);
          await sl<SharedPreferencesStorage>().setCartItems(CartItems(products: []));
          SharedHelper().closeAllDialogs();
          onFinish();
          update();
        },
        cancel: () {
          SharedHelper().closeAllDialogs();
        },
      );
    }
  }

  void selectLocation(Address location) async {
    SharedHelper().scaleDialog(const LoadingWidget(), dismissible: false);
    selectedAddress = location;
    await sl<SharedPreferencesStorage>().setSelectedAddress(selectedAddress!);
    getAvailableBranchForAddress();
    update();
  }

  Future<void> getAvailableBranchForAddress() async {
    Map<String, dynamic> body = {
      "BrandId": "${AppConstants.brandId}",
      "CustomerLatitude": "${selectedAddress?.latitude}",
      "CustomerLongitude": "${selectedAddress?.longitude}",
      "SupportOnlineOrdering": true,
    };
    await getClosestBranch.repository
        .getClosestBranch(body: body)
        .then(
          (value) => value.fold(
            (failure) {
              SharedHelper().closeAllDialogs();
              SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
            },
            (done) {
              if (done != null) {
                selectBranch(done);
              }
            },
          ),
        );
  }

  double? _lat;
  double? _lng;

  Future<void>? _locationInitFuture;

  Future<void> _ensureCustomerLocationReady() {
    _locationInitFuture ??= _initCustomerLocation();
    return _locationInitFuture!;
  }

  Future<void> _initCustomerLocation() async {
    await LocationHelper.requestLocationPermission((pos) async {
      _lat = pos.latitude;
      _lng = pos.longitude;
      print("✅ lat=$_lat lng=$_lng");
    });
  }

  @override
  void onInit() {
    if (!isPickUp) {
      getCustomerAddressesApi();
    } else {
      getOldBranch();
      _ensureCustomerLocationReady();
    }
    super.onInit();
  }

  Future<void> getOldBranch() async {
    selectedBranch = await sl<SharedPreferencesStorage>().getSelectedBranch();
  }
}
