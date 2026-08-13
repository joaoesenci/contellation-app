import 'package:constellation_app/core/infra/models/constellation_line_model.dart';
import 'package:constellation_app/core/infra/models/note_model.dart';

abstract interface class INoteStorageService {
  // ------------------------------------------------------------
  // 📝 NOTES
  // ------------------------------------------------------------
  Future<void> saveNote(NoteModel note);
  Future<List<NoteModel>> getAllNotes();
  Future<void> deleteNotes(List<String> notesId);

  // ------------------------------------------------------------
  // 🧵 CONSTELLATION LINES
  // ------------------------------------------------------------
  Future<void> saveConstellationLines(List<ConstellationLineModel> lines);
  Future<List<ConstellationLineModel>> getAllConstellationLines();
  Future<void> deleteConstellationLines(List<String> linesId);
}
