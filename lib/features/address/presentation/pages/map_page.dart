import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/sdk/sdk_rouutes.dart';
import '../../../../core/utils/theme.dart';
import '../getx/address_controller.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key, required this.initialCamera});

  final CameraPosition initialCamera;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressController>(
        init: AddressController(),
        builder: (controller) {
          return Scaffold(
              appBar: AppBar(
                title: Text("selectYourAddress".tr),
              ),
              body: Stack(
                children: [
                  GoogleMap(
                    onMapCreated: controller.onMapCreated,
                    initialCameraPosition: initialCamera,
                    compassEnabled: controller.compassEnabled,
                    mapToolbarEnabled: controller.mapToolbarEnabled,
                    cameraTargetBounds: controller.cameraTargetBounds,
                    minMaxZoomPreference: controller.minMaxZoomPreference,
                    mapType: controller.mapType,
                    rotateGesturesEnabled: controller.rotateGesturesEnabled,
                    scrollGesturesEnabled: controller.scrollGesturesEnabled,
                    tiltGesturesEnabled: controller.tiltGesturesEnabled,
                    zoomGesturesEnabled: controller.zoomGesturesEnabled,
                    zoomControlsEnabled: controller.zoomControlsEnabled,
                    indoorViewEnabled: controller.indoorViewEnabled,
                    myLocationEnabled: controller.myLocationEnabled,
                    myLocationButtonEnabled: controller.myLocationButtonEnabled,
                    trafficEnabled: controller.myTrafficEnabled,
                    onCameraIdle: () {
                      controller.getLocationName();
                    },
                    onCameraMove: (c) {
                      controller.selectedPosition = c.target;
                    },
                  ),
                  Positioned(
                    bottom: 26,
                    left: 16,
                    right: 16,
                    child: Column(
                      children: [
                        Card(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.circle, color: AppTheme.primaryColor),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    controller.addressDetails,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.fade,
                                    style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size16),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.nameController.text = controller.addressDetails;
                            SDKNav.toNamed(RouteConstant.addressDetailsPage);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: AppTheme.borderRadius,
                              color: AppTheme.primaryColor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'selectYourAddress'.tr,
                                    style: AppTheme.textStyle(color: Colors.white, size: AppTheme.size16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      height: 60,
                      width: 60,
                      padding: EdgeInsets.all(10.0),
                      child: FloatingActionButton(
                        backgroundColor: Colors.white,
                        heroTag: 'recenter',
                        onPressed: () {
                          controller.reCenterCamera();
                        },
                        shape: RoundedRectangleBorder(borderRadius: AppTheme.borderRadius, side: BorderSide(color: Color(0xFFECEDF1))),
                        child: const Icon(
                          Icons.my_location,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: IgnorePointer(
                      ignoring: true,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children:  [
                          Icon(
                            Icons.location_on_outlined,
                            size: 50,
                            color: AppTheme.primaryColor,
                          ),
                          Icon(
                            Icons.location_on_outlined,
                            size: 50,
                            color: Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ));
        });
  }
}
