import 'package:my_custom_widget/core/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'loading_button_widget/iconed_button.dart';
import 'loading_button_widget/progress_button.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.title,
    this.isDoneBtn = true,
    required this.function,
    this.isSmall = false,
    this.isProgress = false,
    this.state,
  }) : assert(isProgress ? state != null : true);

  final String title;
  final bool isDoneBtn;
  final bool isSmall;
  final Function function;
  final bool isProgress;
  final ButtonState? state;

  @override
  Widget build(BuildContext context) {
    return isProgress
        ? ProgressButton.icon(
            radius: 25.0.r,
            height: 50.0,
            iconPadding: 0,
            textStyle: AppTheme.textStyle(
              color: isDoneBtn ? AppTheme.accentColor : AppTheme.textColor,
              size: isSmall ? AppTheme.size12 : AppTheme.size14,
              isBold: true,
            ),
            padding: const EdgeInsets.all(0),
            iconedButtons: {
              ButtonState.normal: IconedButton(
                text: title.toUpperCase(),
                icon: const Icon(Icons.lock, size: 0),
                color: isDoneBtn ? AppTheme.primaryColor : AppTheme.bgThemeColor,
              ),
              ButtonState.loading: IconedButton(color: isDoneBtn ? AppTheme.primaryColor : AppTheme.bgThemeColor),
              ButtonState.fail: const IconedButton(color: AppTheme.redColor),
              ButtonState.success: IconedButton(color: Colors.green.shade400),
            },
            onPressed: function,
            state: state,
          )
        : MaterialButton(
            height: 45.0,
            onPressed: () => function(),
            color: isDoneBtn ? AppTheme.primaryColor : AppTheme.bgThemeColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
              side: BorderSide(color: isDoneBtn ? AppTheme.primaryColor : AppTheme.accentColor),
            ),
            child: SizedBox(
              width: Get.width,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    title.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: AppTheme.textStyle(
                      color: isDoneBtn ? AppTheme.accentColor : AppTheme.primaryColor,
                      size: isSmall ? AppTheme.size12 : AppTheme.size14,
                      isBold: true,
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
