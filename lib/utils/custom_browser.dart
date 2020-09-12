import 'package:flutter/cupertino.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class CustomBrowser extends ChromeSafariBrowser {
  CustomBrowser({browserFallback}) : super(bFallback: browserFallback);

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
  }
}
