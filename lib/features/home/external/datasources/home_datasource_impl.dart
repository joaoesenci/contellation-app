import 'package:constellation_app/core/domain/failures/exeptions.dart';
import 'package:constellation_app/core/infra/fixtures/fixed_contellations_data.dart';
import 'package:constellation_app/core/infra/models/constellation_line_model.dart';
import 'package:constellation_app/core/infra/models/constellation_model.dart';
import 'package:constellation_app/core/infra/models/note_model.dart';
import 'package:constellation_app/core/services/storage/note_storage_service.dart';
import 'package:constellation_app/features/home/infra/datasources/home_datasource.dart';

final class HomeDatasourceImpl implements IHomeDatasource {
  final INoteStorageService _noteStorageService;

  HomeDatasourceImpl(this._noteStorageService);

  // ------------------------------------------------------------
  // ⭐ CONSTELLATIONS
  // ------------------------------------------------------------
  @override
  Future<List<ConstellationModel>> getFixedConstellations() async {
    try {
      return FixedContellationsData.list;
    } on FormatException {
      throw ParseException();
    } catch (e) {
      throw UnknownException();
    }
  }

  // ------------------------------------------------------------
  // 📝 NOTES
  // ------------------------------------------------------------
  @override
  Future<void> saveNote(NoteModel note) async {
    try {
      await _noteStorageService.saveNote(note);
    } on FormatException {
      throw ParseException();
    } catch (e) {
      throw UnknownException();
    }
  }

  @override
  Future<List<NoteModel>> getAllNotes() async {
    try {
      final notes = await _noteStorageService.getAllNotes();

      return notes;
    } on FormatException {
      throw ParseException();
    } catch (e) {
      throw UnknownException();
    }
  }

  @override
  Future<void> deleteNote(List<String> notesId) async {
    try {
      await _noteStorageService.deleteNotes(notesId);
    } on FormatException {
      throw ParseException();
    } catch (e) {
      throw UnknownException();
    }
  }

  // ------------------------------------------------------------
  // 🧵 CONSTELLATION LINES
  // ------------------------------------------------------------
  @override
  Future<void> saveConstellationLines(
    List<ConstellationLineModel> lines,
  ) async {
    try {
      await _noteStorageService.saveConstellationLines(lines);
    } on FormatException {
      throw ParseException();
    } catch (e) {
      throw UnknownException();
    }
  }

  @override
  Future<List<ConstellationLineModel>> getAllConstellationLines() async {
    try {
      final lines = await _noteStorageService.getAllConstellationLines();

      return lines;
    } on FormatException {
      throw ParseException();
    } catch (e) {
      throw UnknownException();
    }
  }

  @override
  Future<void> deleteConstellationLines(List<String> linesId) async {
    try {
      await _noteStorageService.deleteConstellationLines(linesId);
    } on FormatException {
      throw ParseException();
    } catch (e) {
      throw UnknownException();
    }
  }
}
