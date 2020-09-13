import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pushnamed_sample/provider/router_controller.dart';
import 'package:pushnamed_sample/router/config.dart';

enum TabName {
  top,
  config,
}

class TabNavigator extends StatelessWidget {
  final TabItem tabItem;

  const TabNavigator({
    Key key,
    this.tabItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: context.watch<RouterController>().currentTabName != tabItem.name,
      child: Navigator(
        key: context.watch<RouterController>().tabsKey(tabItem.name),
        initialRoute: '/',
        onGenerateRoute: (settings) => router.generateRoute(
          settings,
          tabRootPath: tabItem.path,
        ),
      ),
    );
  }
}

class TabItem {
  final String name;
  final String path;

  TabItem({
    this.name,
    this.path,
  });
}
