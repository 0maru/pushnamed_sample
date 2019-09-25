import 'package:flutter/material.dart';
import 'package:pushnamed_sample/constants.dart';
import 'package:pushnamed_sample/router.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: RouterName.homeRoute,
      onGenerateRoute: Router().generateRoute,
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
            RouterName.feedRoute,
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
            RouterName.homeRoute,
          );
        },
      ),
      body: Center(
        child: Text(data),
      ),
    );
  }
}
