import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/utils/theme.dart';

class DeveloperWidget extends StatelessWidget {
  const DeveloperWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text('developer'.tr.toUpperCase())),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 16),
            Card(
              child: SizedBox(
                height: Get.height * .5,
                width: Get.width * .9,
                child: Column(
                  children: [
                    SizedBox(height: 8),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(35),
                        child: Image.asset(AssetsConsts.mozaicLogo, fit: BoxFit.fitHeight),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        launchUrl(Uri.parse('https://www.mozaicis.com'), mode: LaunchMode.externalApplication);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'www.mozaicis.com'.tr,
                          style: AppTheme.textStyle(color: Colors.blue, size: AppTheme.size14).copyWith(decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
