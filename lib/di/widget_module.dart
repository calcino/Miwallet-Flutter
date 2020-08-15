import 'package:inject/inject.dart';

import '../app/ui/mi_wallet_app.dart';
import '../features/add_count/logic/add_transaction_provider.dart';
import '../features/dashboard/logic/dashboard_provider.dart';
import '../features/home/logic/home_provider.dart';
import '../features/report/logic/report_provider.dart';
import '../features/setting/logic/settings_provider.dart';
import '../features/wallets/logic/wallets_provider.dart';

@module
class WidgetModule {
  @provide
  @singleton
  App getApp(
          WalletsProvider walletsProvider,
          AddTransactionProvider addTransactionProvider,
          ReportProvider reportProvider,
          HomeProvider homeProvider,
          DashboardProvider dashboardProvider,
          SettingsProvider settingsProvider) =>
      App(walletsProvider, addTransactionProvider, reportProvider, homeProvider,
          dashboardProvider, settingsProvider);
}
