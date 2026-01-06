import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/utils/theme.dart';
import '../getx/branch_details_controller.dart';
import '../widgets/branch_details_loading.dart';

class BranchDetailsScreen extends StatelessWidget {
  const BranchDetailsScreen({super.key, required this.branchID});

  final int branchID;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BranchDetailsController>(
        init: BranchDetailsController(branchID),
        builder: (controller) => Scaffold(
              appBar: AppBar(
                title: Text(
                  controller.branchDetails?.name ?? "",
                ),
              ),
              bottomNavigationBar: Column(mainAxisSize: MainAxisSize.min, children: [
                if (!controller.isLoading)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                Icons.location_on,
                                color: AppTheme.accentColor,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("location".tr, style: AppTheme.textStyle(color: AppTheme.accentColor, size: 16))
                            ],
                          ),
                        ),
                        onPressed: () async {
                          String destination = "${controller.branchDetails?.latitude},${controller.branchDetails?.longitude}";
                          String url = "http://maps.google.com/maps?q=loc:$destination (${controller.branchDetails?.name ?? ""})";
                          print(url);
                          await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                Icons.call,
                                color: AppTheme.accentColor,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("callUs".tr, style: AppTheme.textStyle(color: AppTheme.accentColor, size: 16))
                            ],
                          ),
                        ),
                        onPressed: () async {
                          if (controller.branchDetails?.mobile != '' && controller.branchDetails?.mobile != null) {
                            String url = "tel://${controller.branchDetails?.mobile}";
                            if (await canLaunchUrl(Uri.parse(url))) {
                              await launchUrl(Uri.parse(url));
                            } else {
                              throw 'Could not launch $url';
                            }
                          }
                        },
                      ),
                    ],
                  ),
                SizedBox(height: Get.height * .04),
              ]),
              body: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
                child: controller.isLoading
                    ? BranchDetailsLoading()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: AppTheme.borderRadius,
                            child: Hero(
                              tag: "branchImage$branchID",
                              child: CachedNetworkImage(
                                imageUrl: controller.branchDetails?.branchImages?.firstOrNull?.imageUrl ?? "",
                                placeholder: (w, e) => Image.asset(
                                  AssetsConsts.loading,
                                  fit: BoxFit.contain,
                                ),
                                errorWidget: (c, e, s) => Image.asset(AssetsConsts.imageErrorLong, fit: BoxFit.cover),
                                width: Get.width,
                                height: Get.height * .3,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: Get.height * .02),
                          Row(
                            children: [
                              Text(controller.branchDetails?.name ?? "", style: AppTheme.textStyle(color: AppTheme.textColor, size: 18)),
                            ],
                          ),
                          SizedBox(height: Get.height * .02),
                          Row(
                            children: [
                              Expanded(
                                  child: Text(controller.branchDetails?.description ?? "",
                                      style: AppTheme.textStyle(color: AppTheme.textColor, size: 14))),
                            ],
                          ),
                          SizedBox(height: Get.height * .02),
                          Row(
                            children: [
                              Expanded(
                                child: Text('${'address'.tr}: ${controller.branchDetails?.address ?? ""}',
                                    style: AppTheme.textStyle(color: AppTheme.textColor, size: 14)),
                              ),
                            ],
                          ),
                          SizedBox(height: Get.height * .02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${'workingHour'.tr}: ', style: AppTheme.textStyle(color: AppTheme.textColor, size: 14)),
                              Expanded(
                                child: Text(controller.branchDetails?.openTime ?? "",
                                    textDirection: TextDirection.ltr, style: AppTheme.textStyle(color: AppTheme.textColor, size: 14)),
                              ),
                            ],
                          ),
                        ],
                      ),
              ),
            ));
  }
}
