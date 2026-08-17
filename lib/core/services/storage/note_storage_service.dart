import 'package:constellation_app/core/infra/models/note_model.dart';

abstract interface class INoteStorageService {
  Future<void> saveNote(NoteModel note);
  Future<List<NoteModel>> getAllNotes();
  Future<void> deleteNotes(List<String> notesId);
}
