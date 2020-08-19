import 'package:flutter/foundation.dart';
import '../repository/repository.dart';

abstract class BaseProvider extends ChangeNotifier {
  final Repository repository;
  bool isLoading = false;

  BaseProvider(this.repository);
  void dispose();
}