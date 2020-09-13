import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pushnamed_sample/pages/config.dart';
import 'package:pushnamed_sample/pages/top.dart';
import 'package:pushnamed_sample/provider/router_controller.dart';
import 'package:pushnamed_sample/widgets/tab_navigator/tab_navigator.dart';

class BottomNavigation extends StatelessWidget {
  static final tabItems = {
    'top': TabItem(name: 'top', path: TopPage.path),
    'config': TabItem(name: 'config', path: ConfigPage.path),
  };

  const BottomNavigation({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      items: [
        _buildItem(context, tabItem: tabItems['top']),
        _buildItem(context, tabItem: tabItems['config']),
      ],
      onTap: (index) => context.read<RouterController>().changeTab(tabItems.keys.toList()[index]),
    );
  }

  BottomNavigationBarItem _buildItem(BuildContext context, {TabItem tabItem}) {
    return BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
        color: _colorTabMatching(context, tabItem),
      ),
      title: Text(
        tabItem.name,
        style: TextStyle(color: _colorTabMatching(context, tabItem)),
      ),
    );
  }

  Color _colorTabMatching(BuildContext context, TabItem item) {
    if (context.watch<RouterController>().currentTabName == item.name) {
      return Colors.blue;
    }
    return Colors.grey;
  }
}
