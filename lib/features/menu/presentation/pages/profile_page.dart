import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../core/api/api_end_points.dart';
import '../../../../core/constants/assets_constants.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/sdk/sdk_rouutes.dart';
import '../../../../core/utils/theme.dart';
import '../../../../shared/helper/shared_helper.dart';
import '../../../../shared/widgets/bottom_widget.dart';
import '../../../../shared/widgets/hero_logo.dart';
import '../../../auth/presentation/getx/auth_controller.dart';
import '../widget/profile_field_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: AuthController(isProfile: true),
      builder: (controller) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: 0,
            title: Text('profile'.tr),
            actions: [
              IconButton(
                onPressed: () {
                  SDKNav.toNamed(RouteConstant.completeProfile);
                },
                icon: SvgPicture.asset(AssetsConsts.edit, color: AppTheme.primaryColor, width: 30),
              ),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(12),
            child: FutureBuilder<PackageInfo>(
              future: PackageInfo.fromPlatform(),
              builder: (context, snapshot) => Text(
                "copyright ©  Mozaic Loyalty Solutions ${DateTime.now().year} \nVersion ${snapshot.data?.version ?? ""} (${snapshot.data?.buildNumber ?? ""}) ${ApiEndPoints.apiLink.contains("staging") ? "(staging)" : ""}",
                style: AppTheme.textStyle(color: AppTheme.textColor.withOpacity(.7), size: AppTheme.size12),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: controller.isLoading
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: AppTheme.borderRadius,
                          child: Image.asset(AssetsConsts.loading, height: Get.height * .055, width: Get.width * .9, fit: BoxFit.cover),
                        ),
                      );
                    },
                  )
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: Get.height * .02),
                        HeroLogo(),
                        SizedBox(height: Get.height * .02),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            border: Border.all(color: AppTheme.primaryColor.withOpacity(0.4)),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  children: [
                                    ProfileFieldWidget(
                                      title: "${controller.profile?.firstName ?? ""} ${controller.profile?.lastName ?? ""}",
                                      image: AssetsConsts.person,
                                      label: "fullName",
                                    ),
                                    ProfileFieldWidget(
                                      title: controller.profile?.mobileNumber ?? "",
                                      image: AssetsConsts.callProfile,
                                      isLtr: true,
                                      label: 'mobileNumber',
                                    ),
                                    if (controller.profile?.birthDate != null)
                                      ProfileFieldWidget(
                                        title: controller.profile?.birthDate == null
                                            ? ""
                                            : controller.dateFormat.format(controller.dateFormat.parse(controller.profile?.birthDate ?? "")),
                                        image: AssetsConsts.bodIcon,
                                        label: "bod",
                                      ),
                                    if (controller.profile?.gender != null)
                                      ProfileFieldWidget(
                                        title: "${controller.getGender(controller.profile?.gender ?? 1)?.name}",
                                        image: AssetsConsts.genderIcon,
                                        label: "gender",
                                      ),
                                    if (controller.profile?.maritalStatusId != null)
                                      ProfileFieldWidget(
                                        title: "${controller.getMaritalState(controller.profile?.maritalStatusId ?? 0)?.name}",
                                        label: "maritalStatus",
                                      ),
                                    ProfileFieldWidget(
                                      label: "deleteAccount",
                                      title: "deleteAccount".tr,
                                      isDelete: true,
                                      onTap: () {
                                        SharedHelper().needLogin(
                                          () => SharedHelper().bottomSheet(
                                            BottomWidget(
                                              title: 'deleteAccount'.tr,
                                              description: 'confirmDelete'.tr,
                                              confirmColor: AppTheme.redColor,
                                              confirmText: "delete",
                                              onConfirm: () {
                                                controller.logoutOrDeleteAccount(delete: true);
                                              },
                                              onCancel: () {
                                                SDKNav.back();
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: Get.height * .02),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
