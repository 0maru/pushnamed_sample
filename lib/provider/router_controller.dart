import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pushnamed_sample/router/models.dart';
import 'package:pushnamed_sample/utils/custom_browser.dart';

class RouterController<T> with ChangeNotifier {
  RouterController({@required this.locator});

  final Locator locator;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    'top': GlobalKey<NavigatorState>(),
    'config': GlobalKey<NavigatorState>(),
  };
  String _currentTabName = 'top';
  GlobalKey<NavigatorState> get _navigatorKey => locator();
  GlobalKey<NavigatorState> get currentKey => _navigatorKeys[_currentTabName];
  String get currentTabName => _currentTabName;

  GlobalKey<NavigatorState> tabsKey(String tab) => _navigatorKeys[tab];

  void changeTab(String tabName) {
    _currentTabName = tabName;
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
      GlobalKey<NavigatorState> _navigator = _navigatorKeys[_currentTabName];
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
    GlobalKey<NavigatorState> _navigator = _navigatorKeys[_currentTabName];
    if (root) {
      _navigator = _navigatorKey;
    }
    _navigator.currentState.pop<T>(result);
  }
}
