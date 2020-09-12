import 'package:flutter/cupertino.dart';

import 'models.dart';

typedef Widget RouteBuilder(BuildContext context, RouteArgs args);

abstract class Router {
  Route<dynamic> generateRoute(RouteSettings settings);

  factory Router.create(Map<String, RouteBuilder> routeMap) => _RouterImpl(routeMap);
}

class _RouterImpl implements Router {
  final List<RouteEntity> _routerDict;

  _RouterImpl(Map<String, RouteBuilder> routeMap)
      : _routerDict = <RouteEntity>[
          for (var key in routeMap.keys)
            _buildRouteEntry(
              key,
              routeMap[key],
            ),
        ];

  @override
  Route generateRoute(RouteSettings settings) {
    final routePath = _getRoutePath(settings.name);
    RegExpMatch match;
    final routeEntry = _routerDict.firstWhere((it) {
      match = it.regex.firstMatch(routePath);
      return match != null;
    }, orElse: () => null);

    if (routeEntry == null) {
      return null;
    }

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
  }
}

RouteEntity _buildRouteEntry(String name, RouteBuilder routeBuilder) {
  final nameWithParameters = _getRoutePath(name).replaceAllMapped(
    RegExp(':([a-zA-Z0-9_-]+)'),
    (match) {
      final groupName = match.group(1);
      return '(?<$groupName>[a-zA-Z0-9_\\\-\.,:;\+*^%\$@!]+)';
    },
  );
  final regEx = RegExp('^$nameWithParameters\$', caseSensitive: false);
  return RouteEntity(name, regEx, routeBuilder);
}

String _getRoutePath(String name) {
  final parts = name.trim().split('/');
  parts.removeWhere((val) => val == '');
  parts.map((val) {
    if (val.startsWith(':')) {
      return val;
    } else {
      return val.toLowerCase();
    }
  });
  return parts.join('/');
}
