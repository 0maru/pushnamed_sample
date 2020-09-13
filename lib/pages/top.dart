import 'package:flutter/material.dart';

class TopPage extends StatelessWidget {
  static final path = '/top/';

  const TopPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('TopPage'),
        ),
      ),
    );
  }
}
