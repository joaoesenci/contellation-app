import 'package:constellation_app/core/services/note_storage/hive_note_storage_service.dart';
import 'package:constellation_app/core/services/note_storage/note_storage_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_ce/hive.dart';

class CoreModule extends Module {
  final Box<Map> _notesBox;

  CoreModule(this._notesBox);

  @override
  void exportedBinds(Injector i) {
    // ---------- 🔹 INSTANCES ----------
    i.addInstance<Box<Map>>(_notesBox);

    // ---------- 🔸 SERVICES ----------
    i.addSingleton<INoteStorageService>(
      () => HiveNoteStorageService(Modular.get<Box<Map>>()),
    );
  }
}
