import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/core/constants/constants.dart';
import 'package:my_custom_widget/core/utils/theme.dart';
import 'package:my_custom_widget/features/auth/presentation/Getx/auth_controller.dart';
import 'package:my_custom_widget/shared/helper/shared_helper.dart';
import 'package:my_custom_widget/shared/widgets/hero_logo.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/sdk/sdk_rouutes.dart';
import '../../../../my_custom_widget.dart';
import '../../../../shared/screens/app_web_view_Screen.dart';
import '../../../loyalty/presentation/pages/point_schema_page.dart';
import '../getx/menu_controller.dart';
import '../widget/developer_widget.dart';
import '../widget/menu_tab_item_widget.dart';
import 'language_page.dart';

class MenuTab extends StatelessWidget {
  const MenuTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MenuTabController>(
      init: MenuTabController(),
      builder: (controller) => Scaffold(
        backgroundColor: const Color(0xFFF7F9F8),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: AppTheme.gradient1,
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(12), bottomLeft: Radius.circular(12)),
                    border: Border.all(color: AppTheme.primaryColor.withOpacity(0.08)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(children: [const HeroLogo(isWhite: true), const SizedBox(height: 20)]),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppTheme.primaryColor.withOpacity(0.10)),
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
                          title: 'Language',
                          icon: AssetsConsts.language,
                          onTap: () {
                            SharedHelper().bottomSheet(LanguagePage());
                          },
                        ),

                        MenuTabItemWidget(
                          title: 'rateOurApp',
                          icon: AssetsConsts.rateOurApp,
                          onTap: () {
                            if (Platform.isAndroid) {
                              launchUrl(Uri.parse('market://details?id=${AppConstants.bundleIDAndroid}'));
                            } else if (Platform.isIOS) {
                              launchUrl(Uri.parse('https://apps.apple.com/us/app/id${AppConstants.iOSAppID}'));
                            }
                          },
                        ),

                        MenuTabItemWidget(
                          title: 'termsCondition',
                          icon: AssetsConsts.terms,
                          onTap: () {
                            SDKNav.to(AppWebViewScreen(url: AppConstants.termsAndCondition, title: 'termsCondition'.tr));
                          },
                        ),
                        MenuTabItemWidget(
                          title: 'privacyPolicy',
                          icon: AssetsConsts.privacyPolicy,
                          onTap: () {
                            SDKNav.to(AppWebViewScreen(url: AppConstants.privacyPolicy, title: 'privacyPolicy'.tr));
                          },
                        ),
                        MenuTabItemWidget(
                          title: 'developedBy',
                          icon: AssetsConsts.developer,
                          onTap: () {
                            SDKNav.to(DeveloperWidget());
                          },
                          isLast: true,
                        ),
                        MenuTabItemWidget(
                          title: 'nightMode',
                          icon: AssetsConsts.iconLogo,
                          onTap: () {
                            controller.changeTheme = !controller.changeTheme;
                            controller.update();
                            themeController.toggleTheme();
                            Get.back();
                          },
                          isNight: true,
                          controller: controller,
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
