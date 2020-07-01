import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttermiwallet/features/home/ui/history_list.dart';
import 'package:fluttermiwallet/res/colors.dart';
import 'package:fluttermiwallet/res/dimen.dart';
import 'package:fluttermiwallet/res/strings.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
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
    return TabBarView(
      children: [
        HistoryList(),
        HistoryList(),
        HistoryList(),
        HistoryList(),
        HistoryList(),
      ],
      controller: _tabController,
    );
  }

  Widget _appBar() {
    return AppBar(
      centerTitle: true,
      leading: SvgPicture.asset(
        'assets/images/ic_menu.svg',
        color: Colors.black,
        width: ScreenUtil().setWidth(28),
        height: ScreenUtil().setWidth(28),
        fit: BoxFit.fill,
      ),
      bottom: _tabBar(),
      title: Text(
        appName,
        style: TextStyle(fontSize: ScreenUtil().setSp(largeText)),
      ),
    );
  }

  Widget _tabBar() {
    //TODO get data from DB
    return TabBar(
      indicatorColor: orangeColor,
      controller: _tabController,
      tabs: [
        Tab(text: "June",),
        Tab(text: "May",),
        Tab(text: "April",),
        Tab(text: "March",),
        Tab(text: "February",),
      ],
    );
  }

  Widget _floatingActionButton() {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: darkOrangeColor,
      child: Icon(
        Icons.add,
        color: Colors.white,
        size: ScreenUtil().setWidth(30),
      ),
    );
  }
}
