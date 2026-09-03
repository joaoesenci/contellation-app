import 'package:constellation_app/core/services/constellation_layout/constellation_layout_service.dart';
import 'package:constellation_app/core/services/constellation_layout/constellation_layout_service_impl.dart';
import 'package:constellation_app/core/services/storage/hive_note_storage_service.dart';
import 'package:constellation_app/core/services/storage/note_storage_service.dart';
import 'package:constellation_app/shared/constants/app_keys.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_ce/hive.dart';

class CoreModule extends Module {
  final Box<Map> _notesBox;

  CoreModule({required Box<Map> notesBox}) : _notesBox = notesBox;

  @override
  void exportedBinds(Injector i) {
    // ---------- 🔹 INSTANCES ----------
    i.addInstance<Box<Map>>(_notesBox, key: AppKeys.notesBox);

    // ---------- 🔸 SERVICES ----------
    i.addSingleton<IConstellationLayoutService>(
      () => ConstellationLayoutServiceImpl(),
    );
    i.addSingleton<INoteStorageService>(
      () =>
          HiveNoteStorageService(Modular.get<Box<Map>>(key: AppKeys.notesBox)),
    );
  }
}
