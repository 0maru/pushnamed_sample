import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pushnamed_sample/constants.dart';
import 'package:pushnamed_sample/provider/application_controller.dart';
import 'package:pushnamed_sample/provider/router_controller.dart';
import 'package:pushnamed_sample/router.dart';

void main() => runApp(
      MultiProvider(
        providers: [
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

final router = Router.create({
  '/': (context, _) => Home(),
  '/post/:id': (context, args) => Feed.fromRouteArguments(args.body),
  '/withBody': (context, args) => PageWithBody(body: args.body),
});

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: RouterName.homeRoute,
      onGenerateRoute: router.generateRoute,
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/post/1/", arguments: {"key": "value"});
        },
      ),
      body: Column(
        children: [
          FlatButton(
            child: Text('test'),
            onPressed: () {
              Navigator.of(context).pushNamed("/withBody", arguments: {"key": "value"});
            },
          ),
          Center(
            child: Text('Home'),
          ),
        ],
      ),
    );
  }
}

class PageWithBody extends StatelessWidget {
  final Object body;

  const PageWithBody({Key key, @required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Text("Body: $body"),
      ),
    );
  }
}

class Feed extends StatelessWidget {
//  final String data;
  final Object content;

  const Feed._({
    Key key,
    this.content,
  }) : super(key: key);

  const Feed.fromRouteArguments(Object object) : this._(content: object as bool);

  static Object toRouteArguments(Object content) => content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/',
          );
        },
      ),
      body: Center(
        child: Text("$content"),
      ),
    );
  }
}
