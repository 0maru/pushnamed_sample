import 'package:flutter/material.dart';
import './constants.dart';
import './main.dart';

class Router {
  final _routes = <String, Widget Function(BuildContext, RouteSettings)>{
    '/': (context, settings) => Home(),
    RouterName.feedRoute: (context, settings) => Feed(settings.arguments),
  };

  Route<dynamic> generateRoute(RouteSettings settings) {
    final Widget Function(BuildContext, RouteSettings) pageBuilder = _routes[settings.name];
    if (pageBuilder != null) {
      return MaterialPageRoute<void>(
        builder: (BuildContext context) => pageBuilder(context, settings),
        settings: settings,
      );
    }
    assert(false, 'unexpected settings: $settings');
    return null;
  }
}
