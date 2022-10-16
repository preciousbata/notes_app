import 'package:flutter/cupertino.dart';
import 'package:notes_app/firestore_database_service.dart';
import 'package:notes_app/model/note_item_model.dart';

const _notes = 'notes';

class NoteRepository {
  final FirestoreDatabaseService _fireStoreDatabaseService = FirestoreDatabaseService();

  Stream<List<NoteItem>> get notes =>
      _fireStoreDatabaseService.getCollections(_notes).map((event) => event.docs.map((e) => NoteItem.fromJson(e.data())).toList());

  Future<void> deleteNote(String referenceId) async {
    debugPrint('referenceId is $referenceId');
    return await _fireStoreDatabaseService.deleteCollection(_notes, referenceId);
  }

  void createNote(String noteTitle, String noteContent) async {
    try {
      final note = NoteItem(id: DateTime.now().millisecondsSinceEpoch.toString(), title: noteTitle, content: noteContent, createdAt: DateTime.now());
      final reference = await _fireStoreDatabaseService.saveToCollection(_notes, note.toJson());
      note.referenceId = reference.id;
      debugPrint('document reference is ${reference.id}');
      await _fireStoreDatabaseService.updateCollection(_notes, reference.id, note.toJson());
    } catch (exception) {
      debugPrint('exception caught is ${exception.toString()}');
    }
  }
}
