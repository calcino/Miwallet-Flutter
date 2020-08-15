import 'package:flutter/material.dart';

import 'di/app_component.dart';
import 'di/provider_module.dart';
import 'di/repository_module.dart';
import 'di/widget_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var container = await AppComponent.create(
      ProviderModule(), RepositoryModule(), WidgetModule());
  runApp(container.app);
}
