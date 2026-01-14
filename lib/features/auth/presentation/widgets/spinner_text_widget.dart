import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mozaic_loyalty_sdk/core/utils/app_log.dart';

import '../../../../shared/widgets/loading_button_widget/progress_button.dart';
import '../getx/auth_controller.dart';

class SpinnerText extends StatefulWidget {
  SpinnerText({super.key, required this.text, this.textStyle, this.animationStyle});

  final String text;
  final TextStyle? textStyle;
  final Curve? animationStyle;

  _SpinnerTextState createState() => _SpinnerTextState();
}

class _SpinnerTextState extends State<SpinnerText> with SingleTickerProviderStateMixin {
  String topText = "";
  String bottomText = "";

  late AnimationController _spinTextAnimationController;
  late Animation<double> _spinAnimation;

  @override
  void initState() {
    super.initState();
    bottomText = widget.text;
    _spinTextAnimationController = AnimationController(duration: const Duration(milliseconds: 500), vsync: this)
      ..addListener(() => setState(() {}))
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            bottomText = topText;
            topText = "";
            _spinTextAnimationController.value = 0.0;
            if (bottomText == "00" || int.parse(bottomText) < 0) {
              appLog(status, tag: "spinner");
              AuthController authController = Get.find<AuthController>();
              authController.isResend = true;
              authController.btnState = ButtonState.loading;
              authController.update();
              Future.delayed(const Duration(milliseconds: 100), () async {
                authController.btnState = ButtonState.normal;
                authController.update();
              });
              authController.update();
              _spinTextAnimationController.stop();
            }
          });
        }
      });

    _spinAnimation = CurvedAnimation(parent: _spinTextAnimationController, curve: widget.animationStyle ?? Curves.ease);
  }

  @override
  void dispose() {
    _spinTextAnimationController.dispose();
    _spinAnimation.removeListener;
    super.dispose();
  }

  @override
  void didUpdateWidget(SpinnerText oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.text != oldWidget.text) {
      topText = widget.text;
      _spinTextAnimationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      clipper: RectClipper(),
      child: Stack(
        children: <Widget>[
          FractionalTranslation(
            translation: Offset(0.0, 1 - _spinAnimation.value),
            child: Text(
              topText,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: widget.textStyle,
            ),
          ),
          FractionalTranslation(
            translation: Offset(0.0, _spinAnimation.value),
            child: Text(bottomText, maxLines: 1, overflow: TextOverflow.ellipsis, style: widget.textStyle),
          ),
        ],
      ),
    );
  }
}

class RectClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0.0, 0.0, size.width, size.height + 1);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
