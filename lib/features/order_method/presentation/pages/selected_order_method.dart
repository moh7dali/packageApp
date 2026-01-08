import 'package:my_custom_widget/features/address/presentation/widget/my_address_widgets.dart';
import 'package:my_custom_widget/features/order_method/presentation/widgets/background_image.dart';
import 'package:my_custom_widget/features/order_method/presentation/widgets/branch_card_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/theme.dart';
import '../../../../shared/widgets/no_item_widget.dart';
import '../../../../shared/widgets/pagination_list/pagination_list_view.dart';
import '../../../branch/domain/entities/branch_details.dart';
import '../getx/selected_order_method_controller.dart';
import '../widgets/branch_card_widget.dart';
import '../widgets/location_card_widget.dart';

class SelectedOrderMethod extends StatelessWidget {
  const SelectedOrderMethod({super.key, required this.onFinish, this.isPickUp = true});

  final void Function() onFinish;
  final bool isPickUp;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectedOrderMethodController>(
      init: SelectedOrderMethodController(isPickUp: isPickUp, onFinish: onFinish),
      builder: (controller) {
        return AlertDialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: AppTheme.bigBorderRadius),
          content: Container(
            decoration: BoxDecoration(
              color: AppTheme.secondaryColor,
              borderRadius: AppTheme.bigBorderRadius,
              border: Border.all(
                color: AppTheme.primaryColor.withOpacity(0.15), // ✨ soft outline
                width: 1,
              ),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.20), blurRadius: 30, offset: const Offset(0, 18))],
            ),
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  BackgroundImageWidget(title: "pickUp".tr),
                  Container(
                    height: Get.height * .4,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: AppTheme.secondaryColor,
                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(35), bottomRight: Radius.circular(35)),
                    ),
                    child: isPickUp ? PickUp(selectedOrderMethodController: controller) : Delivery(selectedOrderMethodController: controller),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class Delivery extends StatelessWidget {
  const Delivery({super.key, required this.selectedOrderMethodController});

  final SelectedOrderMethodController selectedOrderMethodController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16, top: 8),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'chooseDeliveryLocation'.tr,
                  textAlign: TextAlign.center,
                  style: AppTheme.textStyle(color: AppTheme.whiteColor, size: AppTheme.size14),
                ),
              ],
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                print("allooww");
                Get.toNamed(
                  RouteConstant.mapPage,
                  preventDuplicates: false,
                  arguments: {'initialCamera': CameraPosition(target: selectedOrderMethodController.selectedPosition, zoom: 11.0)},
                );
              },
              child: Card(
                color: AppTheme.secondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: AppTheme.primaryColor),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                       Icon(Icons.add_location_alt_outlined, color: AppTheme.primaryColor, size: 30),
                      Expanded(
                        child: Text(
                          'addNewAddress'.tr,
                          textAlign: TextAlign.center,
                          style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  'savedAddresses'.tr,
                  textAlign: TextAlign.center,
                  style: AppTheme.textStyle(color: AppTheme.whiteColor, size: AppTheme.size14),
                ),
              ],
            ),
            selectedOrderMethodController.isLoadingAddress
                ? buildLoadingList()
                : selectedOrderMethodController.customerAddresses.isEmpty
                ? buildNoAddressView()
                : ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: selectedOrderMethodController.customerAddresses.length,
                    itemBuilder: (context, index) {
                      return LocationWidget(
                        addresses: selectedOrderMethodController.customerAddresses[index],
                        onTap: () {
                          selectedOrderMethodController.selectLocation(selectedOrderMethodController.customerAddresses[index]);
                        },
                        controller: selectedOrderMethodController,
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}

class PickUp extends StatelessWidget {
  const PickUp({super.key, required this.selectedOrderMethodController});

  final SelectedOrderMethodController selectedOrderMethodController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16, top: 10),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppTheme.bgThemeColor,
              borderRadius: AppTheme.borderRadius,
              border: Border.all(color: AppTheme.primaryColor.withOpacity(.18)),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(.06), blurRadius: 18, offset: const Offset(0, 10))],
            ),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Row(
                children: [
                   Icon(Icons.search_rounded, color: AppTheme.primaryColor),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: selectedOrderMethodController.searchController,
                      textAlign: TextAlign.start,
                      onChanged: (value) {
                        selectedOrderMethodController.searchBranches(value);
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(vertical: 8),
                        border: InputBorder.none,
                        hintText: 'searchBranch'.tr,
                        hintStyle: AppTheme.textStyle(color: AppTheme.textColor.withOpacity(.60), size: AppTheme.size12),
                      ),
                      style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size12, isBold: true),
                    ),
                  ),

                  const SizedBox(width: 8),
                  if (selectedOrderMethodController.searchController.text.isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        selectedOrderMethodController.searchController.clear();
                        selectedOrderMethodController.searchBranches("");
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      child: Icon(Icons.close_rounded, color: AppTheme.textColor.withOpacity(.65)),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          selectedOrderMethodController.isLoadingBranches
              ? CircularProgressIndicator()
              : Expanded(
                  child: PaginationListView<BranchDetails>(
                    loadFirstList: () async => selectedOrderMethodController.after
                        ? await selectedOrderMethodController.getAllBranchesList()
                        : await selectedOrderMethodController.getAllBranchesList(page: 1),
                    loadMoreList: (page) async => selectedOrderMethodController.getAllBranchesList(page: page),
                    itemBuilder: (context, value) => BranchWidget(
                      branch: value,
                      onTap: () {
                        selectedOrderMethodController.selectBranch(value);
                      },
                      controller: selectedOrderMethodController,
                    ),
                    emptyWidget: NoItemWidget(isSmall: true),
                    loadingWidget: BranchWidgetLoading(),
                    emptyText: 'emptyBranches'.tr,
                  ),
                ),
        ],
      ),
    );
  }
}
