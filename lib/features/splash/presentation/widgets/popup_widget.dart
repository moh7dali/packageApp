import 'package:my_custom_widget/features/splash/presentation/widgets/circular_countdown_widget.dart';
import 'package:my_custom_widget/shared/widgets/hero_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entities/advertising.dart';
import '../getx/splash_controller.dart';

class PopupWidget extends StatelessWidget {
  final List<Advertising> advertising;
  final SplashController controller;

  const PopupWidget({super.key, required this.advertising, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Image.network(
              advertising[0].advertisingImages.first,
              fit: BoxFit.contain,
              height: Get.height,
              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            ),
          ),
          const Positioned(
              top: 40,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: HeroLogo(
                  height: 0,
                ),
              )),
          Positioned(
              bottom: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: CircularCountdownWidget(
                  onFinish: () {
                    controller.finishAdvertising();
                  },
                ),
              ))
        ],
      ),
    );
  }
}
