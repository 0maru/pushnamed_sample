import 'package:flutter/material.dart';

class Feed extends StatelessWidget {
//  final String data;
  final Map<String, String> contents;

  const Feed._({
    Key key,
    this.contents,
  }) : super(key: key);

  const Feed.fromRouteArguments(Object object) : this._(contents: object as Map<String, String>);

  static Object toRouteArguments(Object object) => object;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/',
          );
        },
      ),
      body: Center(
        child: Text("${contents['key']}"),
      ),
    );
  }
}
