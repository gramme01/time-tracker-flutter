import 'package:flutter/material.dart';

import 'account/account_page.dart';
import 'cupertino_home_scaffold.dart';
import 'entries/entries_page.dart';
import 'jobs/jobs_page.dart';
import 'tab_item.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TabItem _currentTab = TabItem.jobs;
  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.jobs: GlobalKey<NavigatorState>(),
    TabItem.entries: GlobalKey<NavigatorState>(),
    TabItem.account: GlobalKey<NavigatorState>(),
  };

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.jobs: (_) => JobsPage(),
      TabItem.entries: (context) => EntriesPage.create(context),
      TabItem.account: (_) => AccountPage(),
    };
  }

  void _select(TabItem tabitem) {
    if (tabitem == _currentTab) {
      navigatorKeys[tabitem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabitem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !await navigatorKeys[_currentTab].currentState.maybePop(),
      child: CupertinoHomeScaffold(
        currentTab: _currentTab,
        onSelectTab: _select,
        widgetBuilders: widgetBuilders,
        navigatorKeys: navigatorKeys,
      ),
    );
  }
}
