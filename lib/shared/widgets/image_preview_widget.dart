import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';

import '../../core/constants/assets_constants.dart';
import '../../core/sdk/sdk_rouutes.dart';

class ImagePreview extends StatelessWidget {
  const ImagePreview({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        SDKNav.back();
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: GestureDetector(
                  onTap: () {
                    SDKNav.back();
                  },
                  child: DismissiblePage(
                    backgroundColor: Colors.transparent,
                    onDismissed: () {
                      SDKNav.back();
                    },
                    onDragEnd: () {
                      SDKNav.back();
                    },
                    direction: DismissiblePageDismissDirection.multi,
                    isFullScreen: true,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Image.network(
                        image,
                        errorBuilder: (context, error, stackTrace) => Image.asset(AssetsConsts.imageError, fit: BoxFit.fill),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
