import 'package:flutter/cupertino.dart';

import 'models.dart';

typedef Widget RouteBuilder(BuildContext context, RouteArgs args);

abstract class Router {
  static final rootPath = '/';
  Route<dynamic> generateRoute(RouteSettings settings, {String tabRootPath});

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
  Route generateRoute(RouteSettings settings, {String tabRootPath}) {
    String path;
    if (tabRootPath?.isEmpty ?? true) {
      path = settings.name;
    } else {
      path = settings.name == Router.rootPath ? tabRootPath : settings.name;
    }
    debugPrint('pagePath ${path}');
    final routePath = _getRoutePath(path);
    RegExpMatch match;
    final routeEntry = _routerDict.firstWhere((it) {
      match = it.regex.firstMatch(routePath);
      return match != null;
    }, orElse: () => null);

    if (routeEntry == null) {
      // パスが無いときはWebViewで開く
      throw RouterNotFoundException();
    }

    List<String> names = [];
    if (match.groupCount > 0 && match.groupNames.isNotEmpty) {
      names = match.groupNames.toList();
    }

    final pathArgs = <String, String>{
      for (var name in names) name: match.namedGroup(name),
    };

    return CupertinoPageRoute(
      settings: settings,
      builder: (context) => routeEntry.routeBuilder(
        context,
        RouteArgs(
          pathArgs,
          settings.arguments,
        ),
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
