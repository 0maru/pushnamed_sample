import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pushnamed_sample/constants.dart';
import 'package:pushnamed_sample/pages/web_view.dart';
import 'package:pushnamed_sample/provider/application_controller.dart';
import 'package:pushnamed_sample/provider/router_controller.dart';
import 'package:pushnamed_sample/router/config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => GlobalKey<NavigatorState>()),
        ChangeNotifierProvider(
          create: (_) => ApplicationController(locator: _.read),
        ),
        ChangeNotifierProvider(
          create: (_) => RouterController(locator: _.read),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: RouterName.homeRoute,
      onGenerateRoute: router.generateRoute,
      onUnknownRoute: (settings) {
        return CupertinoPageRoute(builder: (_) => WebViewPage(url: settings.name));
      },
    );
  }
}
