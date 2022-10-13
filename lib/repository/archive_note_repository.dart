
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_app/model/archive_model.dart';
import 'package:notes_app/repository/delete_notes_repository.dart';

import '../model/note_item_model.dart';

class ArchiveNote {
  // static Future archiveNotess(String id, Archive archive) async {
    final note =
    FirebaseFirestore.instance.collection('user').doc(id);
  //
  //   final archiveCollection =
  //   FirebaseFirestore.instance.collection('archive').doc();
  //   archive.id = archiveCollection.id;
  //   final json = archive.toJson(note);
  //   await archiveCollection.set(json);
  //   await DeleteNoteRepository.deleteNotes(id);
  // }
  List archivedNotes = [];
  Stream<List<NoteItem>>? archiveNotes() {
    var noteList = FirebaseFirestore.instance
        .collection('user')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => NoteItem.fromJson(doc.data()))
        .toList());
    return null;
  }

}