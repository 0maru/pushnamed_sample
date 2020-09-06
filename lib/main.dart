import 'package:flutter/material.dart';
import 'package:pushnamed_sample/constants.dart';
import 'package:pushnamed_sample/router.dart';

void main() => runApp(MyApp());

final router = Router.create({
  '/': (context, _) => Home(),
  '/post/:id': (context, args) => Feed(args["id"]),
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
          Navigator.pushNamed(
            context,
            '/post/1/',
            arguments: 'test',
          );
        },
      ),
      body: Center(
        child: Text('Home'),
      ),
    );
  }
}

class Feed extends StatelessWidget {
  Feed(this.data);

  final String data;
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
        child: Text(data),
      ),
    );
  }
}
