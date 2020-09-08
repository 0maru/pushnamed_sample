import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApplicationController with ChangeNotifier {
  ApplicationController({@required this.locator});

  final Locator locator;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<NavigatorState> get _navigatorKey => locator();
}
