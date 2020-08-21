import 'package:flutter/material.dart';

import '../../../../utils/date_range.dart';
import '../history_list_widget.dart';

class HomeTabBarView extends StatelessWidget {
  final TabController _tabController;
  final DateTime currentDateTime = DateTime.now();

  HomeTabBarView(this._tabController);

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: children,
      controller: controller,
    );
  }

  TabController get controller => _tabController;

  List<Widget> get children => List<Widget>.unmodifiable([
        HistoryListWidget(
            dateRange: DateRange(
          from: DateTime(currentDateTime.year, currentDateTime.month, 1)
              .toIso8601String(),
          to: DateTime(currentDateTime.year, currentDateTime.month, 31)
              .toIso8601String(),
        )),
        HistoryListWidget(
            dateRange: DateRange(
          from: DateTime(currentDateTime.year, currentDateTime.month - 1, 1)
              .toIso8601String(),
          to: DateTime(currentDateTime.year, currentDateTime.month - 1, 31)
              .toIso8601String(),
        )),
        HistoryListWidget(
          dateRange: DateRange(
              from: DateTime(currentDateTime.year, currentDateTime.month - 2, 1)
                  .toIso8601String(),
              to: DateTime(currentDateTime.year, currentDateTime.month - 2, 31)
                  .toIso8601String()),
        ),
        HistoryListWidget(
            dateRange: DateRange(
          from: DateTime(currentDateTime.year, currentDateTime.month - 3, 1)
              .toIso8601String(),
          to: DateTime(currentDateTime.year, currentDateTime.month - 3, 31)
              .toIso8601String(),
        )),
        HistoryListWidget(
            dateRange: DateRange(
                from:
                    DateTime(currentDateTime.year, currentDateTime.month - 4, 1)
                        .toIso8601String(),
                to: DateTime(
                        currentDateTime.year, currentDateTime.month - 4, 31)
                    .toIso8601String())),
      ]);
}
