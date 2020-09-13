import 'package:flutter/material.dart';
import 'package:pushnamed_sample/pages/config.dart';
import 'package:pushnamed_sample/pages/top.dart';
import 'package:pushnamed_sample/widgets/bottom_navigator/bottom_navigator.dart';
import 'package:pushnamed_sample/widgets/tab_navigator/tab_navigator.dart';

class Home extends StatelessWidget {
  static final path = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          TabNavigator(tabItem: tabItems['top']),
          TabNavigator(tabItem: tabItems['config']),
        ],
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }

  static final tabItems = {
    'top': TabItem(name: 'top', path: TopPage.path),
    'config': TabItem(name: 'config', path: ConfigPage.path),
  };
}
