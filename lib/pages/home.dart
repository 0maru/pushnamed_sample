import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pushnamed_sample/pages/feed.dart';
import 'package:pushnamed_sample/provider/router_controller.dart';

class Home extends StatelessWidget {
  static final path = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(Home.path);
          context.read<RouterController>().push(Home.path, root: true);
        },
      ),
      body: Column(
        children: [
          FlatButton(
            child: Text(Home.path),
            onPressed: () {
              Navigator.of(context).pushNamed<Object>(Home.path);
            },
          ),
          FlatButton(
            child: Text(Feed.path),
            onPressed: () {
              context.read<RouterController>().push(
                    Feed.path,
                    arguments: {"key": "value"},
                    root: true,
                  );
            },
          ),
          FlatButton(
            child: Text('URL'),
            onPressed: () {
              context.read<RouterController>().push('https://google.com', root: true);
            },
          ),
          FlatButton(
            child: Text('not found'),
            onPressed: () async {
              context.read<RouterController>().push('/google.com', root: true);
            },
          ),
        ],
      ),
    );
  }
}
