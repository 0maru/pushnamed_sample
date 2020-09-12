import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pushnamed_sample/router/models.dart';
import 'package:pushnamed_sample/utils/custom_browser.dart';

class RouterController<T> with ChangeNotifier {
  RouterController({@required this.locator});

  final Locator locator;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final Map<String, GlobalKey<NavigatorState>> navigatorKeys = {
    'home': GlobalKey<NavigatorState>(),
    'list': GlobalKey<NavigatorState>(),
    'config': GlobalKey<NavigatorState>(),
  };
  String currentTabName = 'home';
  GlobalKey<NavigatorState> get _navigatorKey => locator();

  void changeTab(String tabName) {
    currentTabName = tabName;
    notifyListeners();
  }

  /// context.read<RouterController>().push<T>(path);
  ///
  /// [root] root のナビケータを操作する場合は true
  Future<T> push<T extends Object>(
    String path, {
    Object arguments,
    bool root = false,
  }) {
    try {
      if (path.startsWith('http')) {
        throw RouterNotFoundException();
      }
      GlobalKey<NavigatorState> _navigator = navigatorKeys[currentTabName];
      if (root) {
        // BottomTabNavigator の上にページを出したい場合
        _navigator = _navigatorKey;
      }
      if (arguments == null) {
        _navigator.currentState.pushNamed(path);
      }
      _navigator.currentState.pushNamed(path, arguments: arguments);
    } on RouterNotFoundException {
      final browser = CustomBrowser();
      browser.open(url: path);
      return null;
    }
  }

  void pop<T extends Object>([T result, bool root = false]) {
    GlobalKey<NavigatorState> _navigator = navigatorKeys[currentTabName];
    if (root) {
      _navigator = _navigatorKey;
    }
    _navigator.currentState.pop<T>(result);
  }
}
