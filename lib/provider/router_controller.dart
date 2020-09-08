import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RouterController with ChangeNotifier {
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
    GlobalKey<NavigatorState> _navigator = navigatorKeys[currentTabName];
    if (root) {
      // BottomTabNavigator の上にページを出したい場合
      _navigator = _navigatorKey;
    }
    return _navigator.currentState.pushNamed<T>(
      path,
      arguments: arguments,
    );
  }

  void pop<T extends Object>([T result, bool root = false]) {
    GlobalKey<NavigatorState> _navigator = navigatorKeys[currentTabName];
    if (root) {
      _navigator = _navigatorKey;
    }
    _navigator.currentState.pop<T>(result);
  }
}
