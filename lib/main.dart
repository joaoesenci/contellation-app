import 'package:constellation_app/app/app_module.dart';
import 'package:constellation_app/app/app_widget.dart';
import 'package:constellation_app/shared/constants/app_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();

  Hive.init(dir.path);

  final Box<Map> notesBox = await Hive.openBox<Map>(AppKeys.notesBox);

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    ModularApp(
      module: AppModule(notesBox: notesBox),
      child: const AppWidget(),
    ),
  );
}
