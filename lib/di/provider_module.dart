import 'package:fluttermiwallet/app/logic/app_provider.dart';
import 'package:fluttermiwallet/features/add_count/logic/add_transaction_provider.dart';
import 'package:fluttermiwallet/features/dashboard/logic/dashboard_provider.dart';
import 'package:fluttermiwallet/features/home/logic/home_provider.dart';
import 'package:fluttermiwallet/features/report/logic/report_provider.dart';
import 'package:fluttermiwallet/features/setting/logic/settings_provider.dart';
import 'package:fluttermiwallet/features/wallets/logic/wallets_provider.dart';
import 'package:fluttermiwallet/repository/repository.dart';
import 'package:inject/inject.dart';

@module
class ProviderModule {
  @provide
  @singleton
  DashboardProvider dashboardProvider(Repository repository) =>
      DashboardProvider(repository);

  @provide
  @singleton
  AppProvider appProvider(Repository repository) => AppProvider(repository);

  @provide
  @singleton
  AddTransactionProvider addTransactionProvider(Repository repository) =>
      AddTransactionProvider(repository);

  @provide
  @singleton
  WalletsProvider walletsProvider(Repository repository) =>
      WalletsProvider(repository);

  @provide
  @singleton
  ReportProvider reportProvider(Repository repository) =>
      ReportProvider(repository);

  @provide
  @singleton
  HomeProvider homeProvider(Repository repository,AddTransactionProvider addTransactionProvider) => HomeProvider(repository,addTransactionProvider);

  @provide
  @singleton
  SettingsProvider settingsProvider(Repository repository) =>
      SettingsProvider(repository);
}
