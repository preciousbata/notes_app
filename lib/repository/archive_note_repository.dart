import 'package:notes_app/firestore_database_service.dart';
import 'package:notes_app/repository/note_repository.dart';

import '../model/note_item_model.dart';

// this should be marked as a repository

const _collectionPath = 'archived';

class ArchiveNoteRepository {
  final _noteRepository = NoteRepository();
  final _fireStoreDatabaseService = FirestoreDatabaseService();

  Stream<List<NoteItem>> get archiveNotes {
    return _fireStoreDatabaseService.getCollections(_collectionPath).map((event) => event.docs.map((e) => NoteItem.fromJson(e.data())).toList());
  }

  // you should separate this into two functions
  // one to add an archived note and one to get it and possibly to delete

  void saveNoteToArchive(NoteItem noteItem) async {
    _fireStoreDatabaseService.saveToCollection(_collectionPath, noteItem.toJson());
    await _noteRepository.deleteNote(noteItem.referenceId);
  }

  void deleteNoteFromArchive(NoteItem noteItem) async {
    await _fireStoreDatabaseService.deleteCollection(_collectionPath, noteItem.referenceId);
  }
}
