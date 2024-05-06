

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebDataView extends StatelessWidget {
  final String url;
  const WebDataView(this.url , {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebView(
        initialUrl: url,
      ),
    );
  }
}
