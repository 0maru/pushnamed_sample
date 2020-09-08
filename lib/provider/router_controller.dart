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
  Future<T> push<T extends Object>(String path, {Object arguments}) {
    return _navigatorKey.currentState.pushNamed<T>(
      path,
      arguments: arguments,
    );
  }

  Future<T> tabPush<T extends Object>(String path, {Object arguments}) {
    return navigatorKeys[currentTabName].currentState.pushNamed<T>(
          path,
          arguments: arguments,
        );
  }
}
