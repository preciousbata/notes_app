import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notes_app/firestore_database_service.dart';
import 'package:notes_app/model/note_item_model.dart';
import 'package:notes_app/repository/archive_note_repository.dart';

class FakeArchiveRepository implements ArchiveNoteRepository {
  final List<NoteItem> _archiveNotes = [];

  @override
  Stream<List<NoteItem>> get archiveNotes => Stream.value(_archiveNotes);

  @override
  void deleteNoteFromArchive(NoteItem note) {
    _archiveNotes.remove(note);
  }

  @override
  void restoreNote(NoteItem noteItem) {
    _archiveNotes.add(noteItem);
  }

  @override
  void saveNoteToArchive(NoteItem noteItem) {
    _archiveNotes.add(noteItem);
  }
}

class FakeFireStoreDbInstance extends FirestoreDatabaseService {
  FakeFireStoreDbInstance(FirebaseFirestore firebaseFirestore) : super(firebaseFirestore);

  @override
  Future<DocumentReference<Map<String, dynamic>>> saveToCollection(String collectionPath, Map<String, dynamic> data) {
    return super.firebaseFirestore.collection(collectionPath).add(data);
  }
}

void main() {
  final NoteItem noteItem = NoteItem.forTest();
  final firestoreDb = FakeFireStoreDbInstance(FakeFirebaseFirestore());

  final ArchiveNoteRepository archiveNoteRepository = FakeArchiveRepository();

  test('should save note to archive when saveNoteToArchive is called', () async {
    await firestoreDb.saveToCollection('archive', {});
    for(int i = 0; i < 5; i++) {
      archiveNoteRepository.saveNoteToArchive(noteItem);
    }
    final archiveNote = await archiveNoteRepository.archiveNotes.first;
    expect(archiveNote.length, 5);
  });
}
