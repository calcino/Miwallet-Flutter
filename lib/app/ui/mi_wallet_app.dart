import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inject/inject.dart';
import 'package:provider/provider.dart';

import '../../app/logic/app_provider.dart';
import '../../features/add_count/logic/add_transaction_provider.dart';
import '../../features/dashboard/logic/dashboard_provider.dart';
import '../../features/home/logic/home_provider.dart';
import '../../features/report/logic/report_provider.dart';
import '../../features/setting/logic/settings_provider.dart';
import '../../features/wallets/logic/wallets_provider.dart';
import '../../res/colors.dart';
import '../../res/strings.dart';
import '../../utils/extentions/color_extentions.dart';
import '../../utils/navigator/bottom_navigation.dart';
import '../../utils/navigator/tab_navigator.dart';

class MiWalletApp extends StatelessWidget {
  final AppProvider appProvider;
  final App app;

  @provide
  const MiWalletApp(
    this.appProvider,
    this.app,
  );

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppProvider>(
      create: (_) => appProvider,
      child: _materialApp(context),
    );
  }

  Widget _materialApp(BuildContext context) {
    ScreenUtil.init(width: 320, height: 640, allowFontScaling: true);
    return MaterialApp(
      title: Strings.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: ColorRes.blueColor.toMaterial(),
          canvasColor: ColorRes.blueColor),
      home: app,
    );
  }
}

class App extends StatefulWidget {

  final WalletsProvider walletsProvider;
  final AddTransactionProvider addTransactionProvider;
  final ReportProvider reportProvider;
  final HomeProvider homeProvider;
  final DashboardProvider dashboardProvider;
  final SettingsProvider settingsProvider;

  @provide
  const App(this.walletsProvider, this.addTransactionProvider,
      this.reportProvider, this.homeProvider, this.dashboardProvider, this.settingsProvider);

  @override
  State<App> createState() => AppState();
}

class AppState extends State<App> {
  TabItem _currentTab = TabItem.home;
  Map<TabItem, GlobalKey<NavigatorState>> _navigatorKeys = {
    TabItem.home: GlobalKey<NavigatorState>(),
    TabItem.wallet: GlobalKey<NavigatorState>(),
    TabItem.report: GlobalKey<NavigatorState>(),
    TabItem.dashboard: GlobalKey<NavigatorState>(),
    TabItem.settings: GlobalKey<NavigatorState>(),
  };

  void _selectTab(TabItem tabItem) {
    if (tabItem == _currentTab) {
      // pop to first route
      _navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentTab].currentState.maybePop();
        if (isFirstRouteInCurrentTab) {
          // if not on the 'main' tab
          if (_currentTab != TabItem.home) {
            // select 'main' tab
            _selectTab(TabItem.home);
            // back button handled by app
            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Stack(children: <Widget>[
          _buildOffstageNavigator<HomeProvider>(
              TabItem.home, widget.homeProvider),
          _buildOffstageNavigator<WalletsProvider>(
              TabItem.wallet, widget.walletsProvider),
          _buildOffstageNavigator<ReportProvider>(
              TabItem.report, widget.reportProvider),
          _buildOffstageNavigator<DashboardProvider>(
              TabItem.dashboard, widget.dashboardProvider),
          _buildOffstageNavigator<SettingsProvider>(
              TabItem.settings, widget.settingsProvider),
        ]),
        bottomNavigationBar: BottomNavigation(
          currentTab: _currentTab,
          onSelectTab: _selectTab,
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator<T extends ChangeNotifier>(
      TabItem tabItem, T provider) {
    return Offstage(
      offstage: _currentTab != tabItem,
      child: TabNavigator<T>(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
        provider: provider,
      ),
    );
  }
}
