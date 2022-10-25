import 'package:flutter/foundation.dart';
import 'package:notes_app/firestore_database_service.dart';
import 'package:notes_app/repository/note_repository.dart';

import '../model/note_item_model.dart';

// this should be marked as a repository

const _collectionPath = 'archived';
const _notePath = 'notes';

class ArchiveNoteRepository {
  final _noteRepository = NoteRepository();
  final _fireStoreDb = FirestoreDatabaseService();

  Stream<List<NoteItem>> get archiveNotes {
    return _fireStoreDb.getCollections(_collectionPath).map(
        (event) => event.docs
            .map((e) => NoteItem.fromJson(e.data()))
            .toList());
  }

  // you should separate this into two functions
  // one to add an archived note and one to get it and possibly to delete

  void saveNoteToArchive(NoteItem noteItem) async {
    _fireStoreDb.saveToCollection(
        _collectionPath, noteItem.toJson());
    await _noteRepository.deleteNote(noteItem.referenceId);
  }

  void deleteNoteFromArchive(NoteItem note) async {
    try {
      debugPrint('referenceId is ${note.referenceId}');
      _fireStoreDb.deleteCollection(
          _collectionPath, note.referenceId);
    } catch (exception) {
      debugPrint(
          'exception caught is ${exception.toString()}');
    }
  }

  void restoreNote(NoteItem noteItem) async {
    _fireStoreDb.saveToCollection(
        _notePath, noteItem.toJson());
    deleteNoteFromArchive(noteItem);
  }
}
