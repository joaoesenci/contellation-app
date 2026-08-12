import 'package:constellation_app/features/splash/presentation/pages/splash_page.dart';
import 'package:constellation_app/features/splash/splash_routes.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashModule extends Module {
  @override
  void binds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r.child(SplashRoutes.init, child: (_) => SplashPage());
  }
}
