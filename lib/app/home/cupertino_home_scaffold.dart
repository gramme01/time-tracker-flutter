import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'tab_item.dart';

class CupertinoHomeScaffold extends StatelessWidget {
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;
  const CupertinoHomeScaffold({
    Key key,
    @required this.currentTab,
    @required this.onSelectTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          _buildItem(TabItem.jobs, context),
          _buildItem(TabItem.entries, context),
          _buildItem(TabItem.account, context),
        ],
        onTap: (index) => onSelectTab(TabItem.values[index]),
      ),
      tabBuilder: (context, index) => CupertinoTabView(
        builder: (context) => Container(),
      ),
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem, BuildContext context) {
    final itemData = TabItemData.allTabs[tabItem];
    final color =
        currentTab == tabItem ? Theme.of(context).primaryColor : Colors.grey;
    return BottomNavigationBarItem(
      icon: Icon(itemData.icon, color: color),
      title: Text(
        itemData.title,
        style: TextStyle(color: color),
      ),
    );
  }
}
