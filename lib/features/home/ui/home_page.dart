import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:unicorndial/unicorndial.dart';

import '../../../res/colors.dart';
import '../../../res/dimen.dart';
import '../../../res/route_name.dart';
import '../../../res/strings.dart';
import '../logic/home_provider.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/home_tab_bar_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}):super(key: key);
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
    _homeProvider = Provider.of<HomeProvider>(context, listen: false);
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _homeProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HomeAppBar(_tabController),
      body: HomeTabBarView(_tabController),
      floatingActionButton: _floatingActionButton(),
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
