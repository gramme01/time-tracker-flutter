import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'tab_item.dart';

class CupertinoHomeScaffold extends StatelessWidget {
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;
  final Map<TabItem, WidgetBuilder> widgetBuilders;

  const CupertinoHomeScaffold({
    Key key,
    @required this.currentTab,
    @required this.onSelectTab,
    @required this.widgetBuilders,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: _buildItems(context),
          onTap: (index) => onSelectTab(TabItem.values[index]),
        ),
        tabBuilder: (context, index) {
          final item = TabItem.values[index];
          return CupertinoTabView(
            builder: (context) => widgetBuilders[item](context),
          );
        });
  }

  // BottomNavigationBarItem _buildItem(TabItem tabItem, BuildContext context) {
  //   final itemData = TabItemData.allTabs[tabItem];
  //   final color =
  //       currentTab == tabItem ? Theme.of(context).primaryColor : Colors.grey;
  //   return BottomNavigationBarItem(
  //     icon: Icon(itemData.icon, color: color),
  //     title: Text(
  //       itemData.title,
  //       style: TextStyle(color: color),
  //     ),
  //   );
  // }

  List<BottomNavigationBarItem> _buildItems(BuildContext context) {
    List<BottomNavigationBarItem> tabs = [];
    for (int i = 0; i < TabItem.values.length; i++) {
      TabItem tabItem = TabItem.values[i];
      final itemData = TabItemData.allTabs[tabItem];
      final color =
          currentTab == tabItem ? Theme.of(context).primaryColor : Colors.grey;
      tabs.add(
        BottomNavigationBarItem(
          icon: Icon(itemData.icon, color: color),
          title: Text(
            itemData.title,
            style: TextStyle(color: color),
          ),
        ),
      );
    }
    return tabs;
  }
}
