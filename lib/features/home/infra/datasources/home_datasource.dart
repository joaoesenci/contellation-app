import 'package:constellation_app/core/infra/models/constellation_model.dart';
import 'package:constellation_app/core/infra/models/note_model.dart';

abstract interface class IHomeDatasource {
  Future<List<ConstellationModel>> getFixedConstellations();
  Future<void> saveNote(NoteModel note);
  Future<List<NoteModel>> getAllNotes();
  Future<void> deleteNote(List<String> notesId);
}
