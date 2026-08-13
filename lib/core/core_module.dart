import 'package:constellation_app/core/services/constellation/constellation_connection_service.dart';
import 'package:constellation_app/core/services/constellation/constellation_layout_service.dart';
import 'package:constellation_app/core/services/storage/hive_note_storage_service.dart';
import 'package:constellation_app/core/services/storage/note_storage_service.dart';
import 'package:constellation_app/shared/constants/app_keys.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_ce/hive.dart';

class CoreModule extends Module {
  final Box<Map> _notesBox;
  final Box<Map> _linesBox;

  CoreModule({required Box<Map> notesBox, required Box<Map> linesBox})
    : _notesBox = notesBox,
      _linesBox = linesBox;

  @override
  void exportedBinds(Injector i) {
    // ---------- 🔹 INSTANCES ----------
    i.addInstance<Box<Map>>(_notesBox, key: AppKeys.notesBox);
    i.addInstance<Box<Map>>(_linesBox, key: AppKeys.constellationLinesBox);

    // ---------- 🔸 SERVICES ----------
    i.addSingleton<INoteStorageService>(
      () => HiveNoteStorageService(
        Modular.get<Box<Map>>(key: AppKeys.notesBox),
        Modular.get<Box<Map>>(key: AppKeys.constellationLinesBox),
      ),
    );
    i.addSingleton<ConstellationLayoutService>(
      () => ConstellationLayoutService(),
    );
    i.addSingleton<ConstellationConnectionService>(
      () => const ConstellationConnectionService(),
    );
  }
}
