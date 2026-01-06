import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/utils/theme.dart';

class UrlWidget extends StatelessWidget {
  const UrlWidget({super.key, this.color, required this.image, required this.url, this.height});

  final String url;
  final String image;
  final Color? color;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: GestureDetector(
        onTap: () async {
          Uri uri = Uri.parse(url);
          if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
            throw 'Could not launch $uri';
          }
        },
        child: SvgPicture.asset(
          image,
          color: color ?? AppTheme.whiteColor,
          height: height ?? Get.height * .04,
        ),
      ),
    );
  }
}
