import 'package:flutter/material.dart';
import 'package:my_custom_widget/core/utils/app_log.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../core/constants/constants.dart';
import '../../my_custom_widget.dart';

class AppWebViewScreen extends StatefulWidget {
  const AppWebViewScreen({super.key, required this.url, required this.title});

  final String url;
  final String title;

  @override
  State<AppWebViewScreen> createState() => _AppWebViewScreenState();
}

class _AppWebViewScreenState extends State<AppWebViewScreen> {
  late final WebViewController controller;

  @override
  void initState() {
    appLog(widget.url, tag: "widget.url");
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url),
          headers: {'DeviceLanguage': "${appLanguage == 'en' ? 2 : 1}", 'Content-Type': 'application/json', 'MI': "${AppConstants.merchantId}"});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
