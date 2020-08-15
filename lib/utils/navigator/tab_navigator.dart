import 'package:flutter/material.dart';
import 'package:fluttermiwallet/res/route_name.dart';
import 'package:fluttermiwallet/utils/navigator/navigation.dart';
import 'package:provider/provider.dart';

import 'bottom_navigation.dart';

class TabNavigator<T extends ChangeNotifier> extends StatelessWidget {
  TabNavigator({this.navigatorKey, this.tabItem, this.provider});

  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;
  final T provider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (_) => provider,
      child: Navigator(
        key: navigatorKey,
        initialRoute: _initialTab(tabItem),
        onGenerateRoute: Navigation.generateRoute,
      ),
    );
  }

  String _initialTab(TabItem tabItem) {
    switch (tabItem) {
      case TabItem.home:
        return RouteName.homePage;
        break;
      case TabItem.wallet:
        return RouteName.walletPage;
        break;
      case TabItem.report:
        return RouteName.reportPage;
        break;
      case TabItem.dashboard:
        return RouteName.dashboardPage;
        break;
      case TabItem.settings:
        return RouteName.settingsPage;
        break;
      default:
        return RouteName.homePage;
        break;
    }
  }
}
