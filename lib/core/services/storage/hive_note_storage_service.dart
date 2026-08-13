import 'package:constellation_app/core/infra/models/constellation_line_model.dart';
import 'package:constellation_app/core/infra/models/note_model.dart';
import 'package:constellation_app/core/services/storage/note_storage_service.dart';
import 'package:hive_ce/hive.dart';

final class HiveNoteStorageService implements INoteStorageService {
  final Box<Map> _notesBox;
  final Box<Map> _linesBox;

  HiveNoteStorageService(this._notesBox, this._linesBox);

  //------------------------------------------------------------
  // 📝 NOTES FUNCTIONS
  //------------------------------------------------------------
  @override
  Future<void> saveNote(NoteModel note) async {
    await _notesBox.put(note.id, note.toMap());
  }

  @override
  Future<List<NoteModel>> getAllNotes() async {
    final models = _notesBox.values
        .map((map) => NoteModel.fromMap(Map<String, dynamic>.from(map)))
        .toList();

    return models;
  }

  @override
  Future<void> deleteNotes(List<String> notesId) async {
    await _notesBox.deleteAll(notesId);
  }

  //------------------------------------------------------------
  // 🧵 LINES FUNCTIONS
  //------------------------------------------------------------
  @override
  Future<void> saveConstellationLines(
    List<ConstellationLineModel> lines,
  ) async {
    if (lines.isEmpty) return;

    final entries = <String, Map>{};

    for (final line in lines) {
      entries[line.id] = line.toMap();
    }

    await _linesBox.putAll(entries);
  }

  @override
  Future<List<ConstellationLineModel>> getAllConstellationLines() async {
    final models = _linesBox.values
        .map(
          (map) =>
              ConstellationLineModel.fromMap(Map<String, dynamic>.from(map)),
        )
        .toList();

    return models;
  }

  @override
  Future<void> deleteConstellationLines(List<String> linesId) async {
    if (linesId.isEmpty) return;

    await _linesBox.deleteAll(linesId);
  }
}
