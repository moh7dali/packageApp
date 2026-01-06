import 'package:my_custom_widget/core/utils/theme.dart';
import 'package:my_custom_widget/features/address/presentation/getx/address_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/my_address_widgets.dart';

class MyAddressPage extends StatelessWidget {
  const MyAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressController>(
      init: AddressController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppTheme.secondaryColor,
          appBar: AppBar(
            backgroundColor: AppTheme.secondaryColor,
            title: Text("myAddresses".tr),
          ),
          body: Padding(
            padding: const EdgeInsets.all(AppTheme.size12),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  buildAddNewAddressButton(controller),
                  SizedBox(height: Get.height * .02),
                  controller.isLoading
                      ? buildLoadingList()
                      : controller.customerAddresses.isEmpty
                          ? buildNoAddressView()
                          : buildAddressList(controller),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
