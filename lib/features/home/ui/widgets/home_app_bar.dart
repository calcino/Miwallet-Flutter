import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../../res/colors.dart';
import '../../../../res/dimen.dart';
import '../../../../res/strings.dart';

class HomeAppBar extends AppBar {
  final TabController _tabController;

  HomeAppBar(this._tabController);

  @override
  Widget get title => Text(
        Strings.appName,
        style: TextStyle(fontSize: ScreenUtil().setSp(DimenRes.largeText)),
      );

  @override
  bool get centerTitle => true;

  @override
  Widget get leading => InkWell(
        onTap: () {
          print('menu tapped');
        },
        child: SvgPicture.asset(
          'assets/images/ic_menu.svg',
          color: Colors.white,
          width: ScreenUtil().setWidth(28),
          height: ScreenUtil().setWidth(28),
          fit: BoxFit.fill,
        ),
      );

  @override
  Size get preferredSize =>
      Size(double.infinity, 2 * kBottomNavigationBarHeight);

  @override
  PreferredSizeWidget get bottom => _tabBar();

  Widget _tabBar() {
    var dateFormatter = DateFormat('MMMM');
    var currentDateTime = DateTime.now();

    return TabBar(
      indicatorColor: ColorRes.orangeColor,
      controller: _tabController,
      tabs: [
        Tab(
          text: dateFormatter.format(currentDateTime),
        ),
        Tab(
          text: dateFormatter.format(DateTime(currentDateTime.year,
              currentDateTime.month - 1, currentDateTime.day)),
        ),
        Tab(
          text: dateFormatter.format(DateTime(currentDateTime.year,
              currentDateTime.month - 2, currentDateTime.day)),
        ),
        Tab(
          text: dateFormatter.format(DateTime(currentDateTime.year,
              currentDateTime.month - 3, currentDateTime.day)),
        ),
        Tab(
          text: dateFormatter.format(DateTime(currentDateTime.year,
              currentDateTime.month - 4, currentDateTime.day)),
        ),
      ],
    );
  }
}
