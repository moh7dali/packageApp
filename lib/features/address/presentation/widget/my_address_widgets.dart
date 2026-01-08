import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_custom_widget/features/address/presentation/getx/address_controller.dart';
import 'package:my_custom_widget/shared/widgets/bottom_widget.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/sdk/sdk_rouutes.dart';
import '../../../../core/utils/theme.dart';
import '../../../../shared/helper/shared_helper.dart';
import '../../../../shared/widgets/no_item_widget.dart';

Widget buildAddNewAddressButton(AddressController controller) {
  return GestureDetector(
    onTap: () {
      SDKNav.toNamed(RouteConstant.mapPage, arguments: {'initialCamera': CameraPosition(target: controller.selectedPosition, zoom: 11.0)});
    },
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(Icons.add, color: AppTheme.textColor),
            const SizedBox(width: 10),
            Text(
              'addNewAddress'.tr,
              style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size16),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildLoadingList() {
  return ListView.builder(
    shrinkWrap: true,
    itemCount: 4,
    itemBuilder: (_, __) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ClipRRect(
        borderRadius: AppTheme.borderRadius,
        child: Image.asset(AssetsConsts.loading, height: Get.height * .075, width: Get.width * .9, fit: BoxFit.cover),
      ),
    ),
  );
}

Widget buildNoAddressView() {
  return Column(
    children: [
      NoItemWidget(),
      Text(
        "noSavedAddresses".tr,
        style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size16),
      ),
    ],
  );
}

Widget buildAddressList(AddressController controller) {
  return ListView.builder(
    shrinkWrap: true,
    itemCount: controller.customerAddresses.length,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      final address = controller.customerAddresses[index];
      final icon = getAddressIcon(address.name);

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: GestureDetector(
          onTap: () => showDeleteBottomSheet(controller, index),
          child: Card(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Image.asset(icon, color: AppTheme.primaryColor, height: Get.height * .04),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          address.name!.toLowerCase().tr,
                          style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size16),
                        ),
                        Text(
                          address.address ?? "",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => showDeleteBottomSheet(controller, index),
                  child: Icon(Icons.more_vert, color: AppTheme.primaryColor),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
        ),
      );
    },
  );
}

String getAddressIcon(String? name) {
  final lowerName = name?.toLowerCase().tr;
  // if (lowerName == 'home'.tr) return AssetsConsts.addressHomeIcon;
  // if (lowerName == 'work'.tr) return AssetsConsts.addressWorkIcon;
  return AssetsConsts.logo;
}

void showDeleteBottomSheet(AddressController controller, int index) {
  final addressName = controller.customerAddresses[index].name!.toLowerCase().tr;

  SharedHelper().bottomSheet(
    SizedBox(
      height: Get.height * .2,
      child: Padding(
        padding: EdgeInsets.all(AppTheme.size20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: AppTheme.primaryColor, borderRadius: BorderRadius.circular(1000)),
              height: 5,
              width: Get.width * .20,
            ),
            SizedBox(height: Get.height * .05),
            ListTile(
              onTap: () {
                SharedHelper().bottomSheet(
                  BottomWidget(
                    title: "deleteAddress".tr,
                    description: "${'thisWillDelete'.tr} $addressName ${'fromYourSavedAddresses'.tr}",
                    onCancel: () {
                      SharedHelper().closeAllDialogs();
                    },
                    onConfirm: () => controller.deleteAddress(id: controller.customerAddresses[index].id!),
                  ),
                );
              },
              title: Text(
                'deleteAddress'.tr,
                style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size16),
              ),
              leading: Icon(Icons.delete, color: AppTheme.redColor),
            ),
          ],
        ),
      ),
    ),
  );
}
