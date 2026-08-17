import 'package:constellation_app/core/infra/models/note_model.dart';
import 'package:constellation_app/core/services/storage/note_storage_service.dart';
import 'package:hive_ce/hive.dart';

final class HiveNoteStorageService implements INoteStorageService {
  final Box<Map> _notesBox;

  HiveNoteStorageService(this._notesBox);

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
}
