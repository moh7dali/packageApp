import 'package:flutter/material.dart';
import 'package:my_custom_widget/core/utils/theme.dart';
import 'package:my_custom_widget/shared/model/pages_model.dart';

class PagesCard extends StatelessWidget {
  const PagesCard({super.key, required this.pageInfo});

  final MainPage pageInfo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pageInfo.onTap();
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: ClipRRect(
              borderRadius: AppTheme.borderRadius,
              child: Image.asset(pageInfo.image, fit: BoxFit.fill),
            ),
          ),
          Positioned(
            child: Text(
              pageInfo.title,
              style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size16),
            ),
          ),
        ],
      ),
    );
  }
}
