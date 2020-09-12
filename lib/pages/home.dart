import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pushnamed_sample/provider/router_controller.dart';
import 'package:pushnamed_sample/utils/custom_browser.dart';

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
          FlatButton(
            child: Text('not found'),
            onPressed: () {
              context.read<RouterController>().push('https://google.com', root: true);
            },
          ),
          FlatButton(
            child: Text('not found'),
            onPressed: () async {
              await CustomBrowser().open(url: 'https://google.com');
            },
          ),
        ],
      ),
    );
  }
}
