import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:ui_web' as ui;
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class WebviewWrapper extends StatefulWidget {
  final String url;
  final GlobalKey globalKey;
  const WebviewWrapper({super.key, required this.url, required this.globalKey});

  @override
  State<WebviewWrapper> createState() => WebviewWrapperState();
}

class WebviewWrapperState extends State<WebviewWrapper> {
  String viewType = '';

  html.IFrameElement iframeElement = html.IFrameElement();

  @override
  Widget build(BuildContext context) {
    viewType = 'iframeElement_${DateTime.now().millisecondsSinceEpoch}';

    ui.platformViewRegistry.registerViewFactory(
      viewType,
      (int viewId) {
        iframeElement = html.IFrameElement()
          ..src = widget.url
          ..style.border = 'none'
          ..width = '100%'
          ..height = '100%'
          ..allow = 'navigation-tracking'; // Enable navigation tracking

        return iframeElement;
      },
    );

    return HtmlElementView(viewType: viewType);
  }
}
