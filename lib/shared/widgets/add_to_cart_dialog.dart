import 'package:my_custom_widget/shared/helper/shared_helper.dart';
import 'package:flutter/material.dart';

import '../../my_custom_widget.dart';

class AddToCartDialog extends StatefulWidget {
  const AddToCartDialog({Key? key}) : super(key: key);

  @override
  State<AddToCartDialog> createState() => _AddToCartDialogState();
}

class _AddToCartDialogState extends State<AddToCartDialog> {
  bool isFirstAnimate = false;
  bool isSecondAnimate = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 300), () {
      isFirstAnimate = true;
      if (mounted) setState(() {});
      Future.delayed(Duration(milliseconds: 300), () {
        isSecondAnimate = true;
        if (mounted) setState(() {});
        Future.delayed(Duration(milliseconds: 300), () {
          isSecondAnimate = true;
          SharedHelper().closeAllDialogs();
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedAlign(
          duration: Duration(milliseconds: 350),
          alignment: isSecondAnimate
              ? appLanguage == 'ar'
                  ? Alignment.topLeft
                  : Alignment.topRight
              : Alignment.center,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 350),
            height: isFirstAnimate ? 50 : 0,
            width: isFirstAnimate ? 50 : 0,
            decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
          ),
        )
      ],
    );
  }
}
