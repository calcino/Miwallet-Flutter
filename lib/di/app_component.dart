import 'package:inject/inject.dart';

import '../app/ui/mi_wallet_app.dart';
import '../di/widget_module.dart';
import 'app_component.inject.dart' as g;
import 'provider_module.dart';
import 'repository_module.dart';

@Injector(const [ProviderModule, RepositoryModule, WidgetModule])
abstract class AppComponent {
  @provide
  MiWalletApp get app;

  static final create = g.AppComponent$Injector.create;
}
