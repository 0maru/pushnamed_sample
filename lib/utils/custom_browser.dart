import 'package:flutter/cupertino.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class CustomBrowser extends ChromeSafariBrowser {
  final BuildContext context;

  CustomBrowser({
    browserFallback,
    this.context,
  }) : super(bFallback: browserFallback);

  @override
  void onOpened() {
    debugPrint("CustomBrowser browser opened");
  }

  @override
  void onCompletedInitialLoad() {
    debugPrint("CustomBrowser browser initial load completed");
  }

  @override
  void onClosed() {
    debugPrint("CustomBrowser browser closed");
    Navigator.of(context).pop();
  }
}
