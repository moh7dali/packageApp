import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/core/constants/constants.dart';
import 'package:my_custom_widget/core/utils/theme.dart';
import 'package:my_custom_widget/features/auth/presentation/Getx/auth_controller.dart';
import 'package:my_custom_widget/shared/helper/shared_helper.dart';
import 'package:my_custom_widget/shared/widgets/hero_logo.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/sdk/sdk_rouutes.dart';
import '../../../../my_custom_widget.dart';
import '../../../loyalty/presentation/pages/point_schema_page.dart';
import '../getx/menu_controller.dart';
import '../widget/menu_tab_item_widget.dart';

class MenuTab extends StatelessWidget {
  const MenuTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MenuTabController>(
      init: MenuTabController(),
      builder: (controller) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.bgThemeColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppTheme.primaryColor.withOpacity(0.4)),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 18, offset: const Offset(0, 10))],
                    ),
                    child: Column(
                      children: [
                        MenuTabItemWidget(
                          title: 'profile',
                          icon: AssetsConsts.menuProfile,
                          onTap: () async {
                            SharedHelper().needLogin(() {
                              Get.delete<AuthController>();
                              return SDKNav.toNamed(RouteConstant.profilePage);
                            });
                          },
                        ),
                        MenuTabItemWidget(
                          title: 'pointSchema',
                          icon: AssetsConsts.pointSchema,
                          onTap: () {
                            SharedHelper().scaleDialog(PointSchemaPage());
                          },
                        ),

                        MenuTabItemWidget(
                          title: 'inviteFriends',
                          icon: AssetsConsts.inviteFriend,
                          onTap: () {
                            SharedHelper().needLogin(() => SDKNav.toNamed(RouteConstant.invitePage));
                          },
                        ),
                        MenuTabItemWidget(
                          title: 'termsCondition',
                          icon: AssetsConsts.terms,
                          onTap: () {
                            SDKNav.toNamed(
                              RouteConstant.appWebViewPage,
                              arguments: {"title": 'termsCondition'.tr, "url": AppConstants.termsAndCondition},
                            );
                          },
                        ),
                        MenuTabItemWidget(
                          title: 'privacyPolicy',
                          icon: AssetsConsts.privacyPolicy,
                          onTap: () {
                            SDKNav.toNamed(RouteConstant.appWebViewPage, arguments: {"title": 'privacyPolicy'.tr, "url": AppConstants.privacyPolicy});
                          },
                        ),
                        MenuTabItemWidget(
                          title: 'developedBy',
                          icon: AssetsConsts.developer,
                          onTap: () {
                            SDKNav.toNamed(RouteConstant.developerWidget);
                          },
                          isLast: true,
                        ),
                      ],
                    ),
                  ),
                ),
                if (kDebugMode) ...[
                  const SizedBox(height: 14),
                  // Debug Logout Card (still premium)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppTheme.primaryColor.withOpacity(0.10)),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 16, offset: const Offset(0, 10))],
                    ),
                    child: MenuTabItemWidget(
                      title: 'logOut',
                      icon: AssetsConsts.logOut,
                      onTap: () {
                        SharedHelper().needLogin(
                          () => SharedHelper().actionDialog(
                            '',
                            'confirmLogout',
                            confirmText: 'logOut'.tr,
                            confirm: () async => controller.logoutOrDeleteAccount(),
                            cancel: () => SDKNav.back(),
                          ),
                        );
                      },
                      isLast: true,
                    ),
                  ),
                ],
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
