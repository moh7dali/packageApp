import 'package:my_custom_widget/shared/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../../core/utils/theme.dart';
import '../../../../shared/widgets/hero_logo.dart';
import '../getx/invite_controller.dart';

class InvitePage extends StatelessWidget {
  const InvitePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InviteFriendsController>(
      init: InviteFriendsController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(title: Text('inviteFriends'.tr)),
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                child: AppButton(title: 'invite'.tr, function: () => controller.invite()),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                HeroLogo(smallLogo: true),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: AppTheme.gradient1,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: AppTheme.primaryColor.withOpacity(.10)),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(.06), blurRadius: 22, offset: const Offset(0, 12))],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
                        child: Column(
                          children: [
                            Text(
                              'inviteTxt'.tr,
                              textAlign: TextAlign.center,
                              style: AppTheme.textStyle(color: AppTheme.whiteColor, size: AppTheme.size16, isBold: true),
                            ),
                            const SizedBox(height: 14),

                            GestureDetector(
                              onTap: () async {
                                await Clipboard.setData(ClipboardData(text: controller.code.tr));
                                Fluttertoast.showToast(msg: 'copiedToClipboard'.tr);
                              },
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: AppTheme.whiteColor,
                                  borderRadius: BorderRadius.circular(18),
                                  border: Border.all(color: AppTheme.primaryColor.withOpacity(.14)),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 44,
                                      height: 44,
                                      decoration: BoxDecoration(
                                        color: AppTheme.primaryColor.withOpacity(.10),
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(color: AppTheme.primaryColor.withOpacity(.16)),
                                      ),
                                      child: Icon(Icons.card_giftcard_rounded, color: AppTheme.primaryColor),
                                    ),
                                    const SizedBox(width: 12),

                                    Expanded(
                                      child: Directionality(
                                        textDirection: TextDirection.ltr,
                                        child: Text(
                                          controller.code.tr,
                                          textAlign: TextAlign.center,
                                          style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size30, isBold: true),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 12),

                                    Container(
                                      width: 44,
                                      height: 44,
                                      decoration: BoxDecoration(color: AppTheme.primaryColor.withOpacity(.10), shape: BoxShape.circle),
                                      child: Icon(Icons.copy_rounded, color: AppTheme.primaryColor, size: 22),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
