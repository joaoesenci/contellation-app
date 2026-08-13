import 'package:constellation_app/core/domain/entities/note_entity.dart';
import 'package:constellation_app/core/domain/entities/constellation_line_entity.dart';

final class ConstellationConnectionService {
  static const int _maxConnectionsPerStar = 3;

  const ConstellationConnectionService();

  List<ConstellationLineEntity> generateInitialConnections(
    List<NoteEntity> notes,
  ) {
    if (notes.length < 2) {
      return const [];
    }

    final sortedNotes = List<NoteEntity>.from(notes)..sort(_compareNotes);

    final connections = <ConstellationLineEntity>[];
    final remainingNotes = List<NoteEntity>.from(sortedNotes);

    var currentNote = remainingNotes.removeAt(0);

    while (remainingNotes.isNotEmpty) {
      final nextNote = _findClosestNote(currentNote, remainingNotes);

      connections.add(_createLine(from: currentNote, to: nextNote));

      remainingNotes.remove(nextNote);
      currentNote = nextNote;
    }

    return connections;
  }

  List<ConstellationLineEntity> connectNewNote({
    required NoteEntity newNote,
    required List<NoteEntity> existingNotes,
    required List<ConstellationLineEntity> existingConnections,
  }) {
    if (existingNotes.isEmpty) {
      return existingConnections;
    }

    final candidates = existingNotes
        .where((note) => note.id != newNote.id)
        .toList();

    if (candidates.isEmpty) {
      return existingConnections;
    }

    final connectionCounts = _buildConnectionCounts(
      notes: [...existingNotes, newNote],
      connections: existingConnections,
    );

    final availableCandidates = candidates
        .where(
          (note) => (connectionCounts[note.id] ?? 0) < _maxConnectionsPerStar,
        )
        .toList();

    if (availableCandidates.isEmpty) {
      return existingConnections;
    }

    availableCandidates.sort((first, second) {
      final firstDistance = _distanceSquared(newNote, first);

      final secondDistance = _distanceSquared(newNote, second);

      if (firstDistance != secondDistance) {
        return firstDistance.compareTo(secondDistance);
      }

      final firstConnections = connectionCounts[first.id] ?? 0;

      final secondConnections = connectionCounts[second.id] ?? 0;

      if (firstConnections != secondConnections) {
        return firstConnections.compareTo(secondConnections);
      }

      return _compareNotes(first, second);
    });

    final closestCandidate = availableCandidates.first;

    final newConnection = _createLine(from: newNote, to: closestCandidate);

    return [...existingConnections, newConnection];
  }

  Map<String, int> _buildConnectionCounts({
    required List<NoteEntity> notes,
    required List<ConstellationLineEntity> connections,
  }) {
    final counts = <String, int>{for (final note in notes) note.id: 0};

    for (final connection in connections) {
      if (counts.containsKey(connection.fromNoteId)) {
        counts[connection.fromNoteId] = counts[connection.fromNoteId]! + 1;
      }

      if (counts.containsKey(connection.toNoteId)) {
        counts[connection.toNoteId] = counts[connection.toNoteId]! + 1;
      }
    }

    return counts;
  }

  NoteEntity _findClosestNote(NoteEntity source, List<NoteEntity> candidates) {
    var closest = candidates.first;
    var closestDistance = _distanceSquared(source, closest);

    for (final candidate in candidates.skip(1)) {
      final distance = _distanceSquared(source, candidate);

      if (distance < closestDistance ||
          (distance == closestDistance &&
              _compareNotes(candidate, closest) < 0)) {
        closest = candidate;
        closestDistance = distance;
      }
    }

    return closest;
  }

  double _distanceSquared(NoteEntity first, NoteEntity second) {
    final dx = first.positionX - second.positionX;
    final dy = first.positionY - second.positionY;

    return (dx * dx) + (dy * dy);
  }

  int _compareNotes(NoteEntity first, NoteEntity second) {
    final xComparison = first.positionX.compareTo(second.positionX);

    if (xComparison != 0) {
      return xComparison;
    }

    final yComparison = first.positionY.compareTo(second.positionY);

    if (yComparison != 0) {
      return yComparison;
    }

    return first.id.compareTo(second.id);
  }

  ConstellationLineEntity _createLine({
    required NoteEntity from,
    required NoteEntity to,
  }) {
    final firstId = from.id.compareTo(to.id) < 0 ? from.id : to.id;

    final secondId = from.id.compareTo(to.id) < 0 ? to.id : from.id;

    return ConstellationLineEntity(
      id: '$firstId-$secondId',
      fromNoteId: firstId,
      toNoteId: secondId,
    );
  }
}
