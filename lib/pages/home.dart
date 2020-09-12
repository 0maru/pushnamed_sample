import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacementNamed("/");
        },
      ),
      body: Column(
        children: [
          FlatButton(
            child: Text('/feed/123/'),
            onPressed: () {
              Navigator.of(context).pushNamed(
                "/feed/123/",
                arguments: {"key": "value"},
              );
            },
          ),
          FlatButton(
            child: Text('/feed/:id/'),
            onPressed: () {
              Navigator.of(context).pushNamed(
                "/feed/456/",
                arguments: {"key": "value"},
              );
            },
          ),
          FlatButton(
            child: Text('/withBody/'),
            onPressed: () {
              Navigator.of(context).pushNamed(
                "/withBody/",
                arguments: {"key": "value"},
              );
            },
          ),
        ],
      ),
    );
  }
}
