import 'package:flutter/material.dart';
import 'package:pushnamed_sample/utils/custom_browser.dart';

class WebViewPage extends StatefulWidget {
  static final path = '/webview/';
  final String url;

  WebViewPage({
    Key key,
    this.url,
  }) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  @override
  void initState() {
    super.initState();
    debugPrint('WebViewPage [initState]');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final browser = CustomBrowser(context: context);
      browser.open(url: widget.url);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
