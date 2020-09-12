import 'package:flutter/material.dart';

typedef Widget RouteBuilder(BuildContext context, RouteArgs args);

class RouteArgs {
  final Map<String, String> pathArgs;
  final Object body;

  RouteArgs(
    this.pathArgs, [
    this.body,
  ]);

  String operator [](String key) => pathArgs[key];
}

class RouteEntity {
  final String name;
  final RegExp regex;
  final RouteBuilder routeBuilder;

  RouteEntity(
    this.name,
    this.regex,
    this.routeBuilder,
  );
}

class RouterNotFoundException implements Exception {}
