import 'package:flutter/material.dart';

import '../../my_custom_widget.dart';

class TranslatedImageWidget extends StatelessWidget {
  const TranslatedImageWidget({super.key, required this.imgAr, required this.imgEn});

  final String imgEn;
  final String imgAr;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      appLanguage == "ar" ? imgAr : imgEn,
      fit: BoxFit.cover,
    );
  }
}
