import 'package:flutter/material.dart';

class ConfigPage extends StatelessWidget {
  static final path = '/config/';

  const ConfigPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('ConfigPage'),
        ),
      ),
    );
  }
}
