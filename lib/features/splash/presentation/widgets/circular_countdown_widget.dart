import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_custom_widget/core/utils/theme.dart';

class CircularCountdownWidget extends StatefulWidget {
  final VoidCallback onFinish;

  const CircularCountdownWidget({super.key, required this.onFinish});

  @override
  State<CircularCountdownWidget> createState() => _CircularCountdownWidgetState();
}

class _CircularCountdownWidgetState extends State<CircularCountdownWidget> {
  double progress = 1.0;
  int countdown = 3;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  void startCountdown() {
    progress = 1.0;
    countdown = 3;
    if (mounted) setState(() {});
    const oneSec = Duration(milliseconds: 333);
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (countdown == 0) {
            timer.cancel();
            widget.onFinish.call();
          } else {
            countdown--;
          }
        });
      }
    });
    timer = Timer.periodic(oneSec, (Timer t) {
      if (mounted) {
        setState(() {
          if (progress == 0) {
            t.cancel();
          } else {
            progress = progress - .1;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        CircularProgressIndicator(value: progress, strokeWidth: 2.0),
        Text(
          countdown.toString(),
          style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size20),
        ),
      ],
    );
  }

  @override
  void dispose() {
    timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }
}
