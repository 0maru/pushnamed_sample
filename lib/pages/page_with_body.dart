import 'package:flutter/material.dart';

class PageWithBody extends StatelessWidget {
  final Object body;

  const PageWithBody({
    Key key,
    @required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Text("Body: $body"),
      ),
    );
  }
}
