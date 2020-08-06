import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttermiwallet/app/logic/app_provider.dart';
import 'package:fluttermiwallet/features/home/logic/history_provider.dart';
import 'package:fluttermiwallet/features/home/logic/home_provider.dart';
import 'package:fluttermiwallet/features/home/ui/history_list.dart';
import 'package:fluttermiwallet/res/colors.dart';
import 'package:fluttermiwallet/res/dimen.dart';
import 'package:fluttermiwallet/res/route_name.dart';
import 'package:fluttermiwallet/res/strings.dart';
import 'package:fluttermiwallet/utils/date_range.dart';
import 'package:intl/intl.dart';
import 'package:unicorndial/unicorndial.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  HomeProvider _homeProvider;

  @override
  void initState() {
    super.initState();
    var appProvider = context.read<AppProvider>();
    _homeProvider = HomeProvider(appProvider.db);
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 320, height: 640);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: _body(),
      floatingActionButton: _floatingActionButton(),
    );
  }

  Widget _body() {
    var currentDateTime = DateTime.now();

    return TabBarView(
      children: [
        HistoryList(
            dateRange: DateRange(
          from: DateTime(currentDateTime.year, currentDateTime.month, 1)
              .toIso8601String(),
          to: DateTime(currentDateTime.year, currentDateTime.month, 31)
              .toIso8601String(),
        )),
        HistoryList(
            dateRange: DateRange(
          from: DateTime(currentDateTime.year, currentDateTime.month - 1, 1)
              .toIso8601String(),
          to: DateTime(currentDateTime.year, currentDateTime.month - 1, 31)
              .toIso8601String(),
        )),
        HistoryList(
          dateRange: DateRange(
              from: DateTime(currentDateTime.year, currentDateTime.month - 2, 1)
                  .toIso8601String(),
              to: DateTime(currentDateTime.year, currentDateTime.month - 2, 31)
                  .toIso8601String()),
        ),
        HistoryList(
            dateRange: DateRange(
          from: DateTime(currentDateTime.year, currentDateTime.month - 3, 1)
              .toIso8601String(),
          to: DateTime(currentDateTime.year, currentDateTime.month - 3, 31)
              .toIso8601String(),
        )),
        HistoryList(
            dateRange: DateRange(
                from:
                    DateTime(currentDateTime.year, currentDateTime.month - 4, 1)
                        .toIso8601String(),
                to: DateTime(
                        currentDateTime.year, currentDateTime.month - 4, 31)
                    .toIso8601String())),
      ],
      controller: _tabController,
    );
  }

  Widget _appBar() {
    return AppBar(
      centerTitle: true,
      leading: InkWell(
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
      ),
      bottom: _tabBar(),
      title: Text(
        Strings.appName,
        style: TextStyle(fontSize: ScreenUtil().setSp(DimenRes.largeText)),
      ),
    );
  }

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

  Widget _floatingActionButton() {
    Widget _createUnicornButton(
        String title, IconData iconData, Function onPressed) {
      return UnicornButton(
          hasLabel: true,
          labelText: title,
          labelHasShadow: false,
          labelBackgroundColor: Colors.transparent,
          labelFontSize: ScreenUtil().setSp(DimenRes.normalText),
          labelColor: ColorRes.blueColor,
          currentButton: FloatingActionButton(
            heroTag: title,
            elevation: 10,
            backgroundColor: ColorRes.veryLightBlueColor,
            mini: true,
            child: Icon(
              iconData,
              color: ColorRes.blueColor,
            ),
            onPressed: onPressed,
          ));
    }

    var childButtons = List<UnicornButton>();

    childButtons.add(
      _createUnicornButton(
        Strings.expense,
        Icons.arrow_upward,
        () {
          Navigator.pushNamed(context, RouteName.addTransactionPage,
              arguments: false);
        },
      ),
    );
    childButtons.add(
      _createUnicornButton(
        Strings.income,
        Icons.arrow_downward,
        () {
          Navigator.pushNamed(context, RouteName.addTransactionPage,
              arguments: true);
        },
      ),
    );

    return UnicornDialer(
        backgroundColor: Color.fromRGBO(255, 255, 255, 0.6),
        parentButtonBackground: ColorRes.darkOrangeColor,
        orientation: UnicornOrientation.VERTICAL,
        parentButton: Icon(Icons.add, color: Colors.white),
        childButtons: childButtons);
  }
}
