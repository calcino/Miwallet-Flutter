import 'package:fluttermiwallet/base/base_provider.dart';
import 'package:fluttermiwallet/repository/repository.dart';
import 'package:inject/inject.dart';

class AppProvider extends BaseProvider {
  @provide
  AppProvider(Repository repository) : super(repository);
}