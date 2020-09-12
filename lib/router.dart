import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef Widget RouteBuilder(
  BuildContext context,
  RouteArgs args,
);

/// https:// がついていたら Exception を出してブラウザで開くようにする？
abstract class Router {
  Route<dynamic> generateRoute(RouteSettings settings);

  factory Router.create(Map<String, RouteBuilder> routeMap) => _RouterImpl(routeMap);
}

class _RouterImpl implements Router {
  final List<_RouteEntity> _routerDict;

  _RouterImpl(Map<String, RouteBuilder> routeMap)
      : _routerDict = <_RouteEntity>[
          for (var key in routeMap.keys) _buildRouteEntry(key, routeMap[key]),
        ];

  @override
  Route generateRoute(RouteSettings settings) {
    try {
      final routePath = _getRoutePath(settings.name);
      RegExpMatch match;
      final routeEntry = _routerDict.firstWhere((it) {
        match = it.regex.firstMatch(routePath);
        return match != null;
      }, orElse: () => null);

      if (routeEntry == null) return null;

      List<String> names;

      if (match.groupCount > 0 && match.groupNames.isNotEmpty) {
        names = match.groupNames.toList();
      } else {
        names = [];
      }

      final pathArgs = <String, String>{
        for (var name in names) name: match.namedGroup(name),
      };

      return CupertinoPageRoute(
        settings: settings,
        builder: (context) => routeEntry.routeBuilder(
          context,
          RouteArgs(pathArgs, settings.arguments),
        ),
      );
    } on RouterNotFoundException {}
  }
}

class _RouteEntity {
  final String name;
  final RegExp regex;
  final RouteBuilder routeBuilder;

  _RouteEntity(
    this.name,
    this.regex,
    this.routeBuilder,
  );
}

_RouteEntity _buildRouteEntry(String name, RouteBuilder routeBuilder) {
  final nameWithParameters = _getRoutePath(name).replaceAllMapped(
    RegExp(':([a-zA-Z0-9_-]+)'),
    (match) {
      final groupName = match.group(1);
      return '(?<$groupName>[a-zA-Z0-9_\\\-\.,:;\+*^%\$@!]+)';
    },
  );
  final regex = RegExp('^$nameWithParameters\$', caseSensitive: false);
  return _RouteEntity(name, regex, routeBuilder);
}

String _getRoutePath(String name) {
  var path = name.trim();
  final parts = path.split('/');
  parts.removeWhere((value) => value == '');
  parts.map((value) {
    if (value.startsWith(':')) {
      return value;
    } else {
      return value.toLowerCase();
    }
  });
  path = parts.join('/');
  return path;
}

class RouteArgs {
  final Map<String, String> pathArgs;
  final Object body;

  RouteArgs(
    this.pathArgs, [
    this.body,
  ]);

  String operator [](String key) => pathArgs[key];
}

class RouterNotFoundException implements Exception {}
