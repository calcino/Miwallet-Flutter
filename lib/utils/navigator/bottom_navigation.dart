import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttermiwallet/res/colors.dart';

enum TabItem { home, wallet, report, dashboard, settings }

Map<TabItem, String> tabName = {
  TabItem.home: 'Home',
  TabItem.wallet: 'Wallet',
  TabItem.report: 'Report',
  TabItem.dashboard: 'Dashboard',
  TabItem.settings: 'Settings',
};

class BottomNavigation extends StatelessWidget {
  BottomNavigation(
      {this.currentTab,
      this.onSelectTab,
      this.activeTabColor = ColorRes.blueColor,
      this.inActiveTabColor = Colors.grey});

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;
  final Color activeTabColor;
  final Color inActiveTabColor;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      elevation: 10,
      items: [
        _buildItem(tabItem: TabItem.home),
        _buildItem(tabItem: TabItem.wallet),
        _buildItem(tabItem: TabItem.report),
        _buildItem(tabItem: TabItem.dashboard),
        _buildItem(tabItem: TabItem.settings),
      ],
      onTap: (index) => onSelectTab(
        TabItem.values[index],
      ),
    );
  }

  BottomNavigationBarItem _buildItem({TabItem tabItem}) {
    String text = tabName[tabItem];
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        _tabSvgPath(tabItem),
        color: _colorTabMatching(item: tabItem),
      ),
      title: Text(
        text,
        style: TextStyle(
          color: _colorTabMatching(item: tabItem),
        ),
      ),
    );
  }

  String _tabSvgPath(TabItem tabItem) {
    switch (tabItem) {
      case TabItem.home:
        return 'assets/images/menu/ic_home.svg';
        break;
      case TabItem.wallet:
        return 'assets/images/menu/ic_wallet.svg';
        break;
      case TabItem.report:
        return 'assets/images/menu/ic_report.svg';
        break;
      case TabItem.dashboard:
        return 'assets/images/menu/ic_dashboard.svg';
        break;
      case TabItem.settings:
        return 'assets/images/menu/ic_settings.svg';
        break;
      default:
        return 'assets/images/menu/ic_home.svg';
        break;
    }
  }

  Color _colorTabMatching({TabItem item}) {
    return currentTab == item ? activeTabColor : inActiveTabColor;
  }
}
