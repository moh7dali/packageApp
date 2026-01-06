import 'package:my_custom_widget/features/address/domain/entity/address.dart';
import 'package:my_custom_widget/features/address/presentation/widget/my_address_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/theme.dart';
import '../getx/selected_order_method_controller.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({super.key, required this.addresses, required this.onTap, required this.controller});

  final Address addresses;
  final Function() onTap;
  final SelectedOrderMethodController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              color: controller.selectedAddress?.id == addresses.id ? AppTheme.primaryColor : Colors.grey.shade200,
              borderRadius: AppTheme.borderRadius),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Image.asset(
                    getAddressIcon(addresses.name ?? ""),
                    color: controller.selectedAddress?.id == addresses.id ? AppTheme.textColor : AppTheme.primaryColor,
                    height: Get.height * .03,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Text(
                  '${addresses.name ?? ""}, ${addresses.address ?? ""}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.textStyle(
                      color: controller.selectedAddress?.id == addresses.id ? AppTheme.whiteColor : AppTheme.blackColor, size: AppTheme.size14),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
