import 'package:constellation_app/app/app_routes.dart';
import 'package:constellation_app/core/core_module.dart';
import 'package:constellation_app/features/home/home_module.dart';
import 'package:constellation_app/features/splash/splash_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_ce/hive.dart';

class AppModule extends Module {
  final Box<Map> _notesBox;
  final Box<Map> _constellationLinesBox;

  AppModule({
    required Box<Map> notesBox,
    required Box<Map> constellationLinesBox,
  }) : _notesBox = notesBox,
       _constellationLinesBox = constellationLinesBox;

  @override
  List<Module> get imports => [
    CoreModule(notesBox: _notesBox, linesBox: _constellationLinesBox),
  ];

  @override
  void routes(RouteManager r) {
    r.module(AppRoutes.splash, module: SplashModule());

    r.module(AppRoutes.home, module: HomeModule());
  }
}
