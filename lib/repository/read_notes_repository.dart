import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_app/model/note_item_model.dart';

class ReadNote {
  Stream<List<NoteItem>> readNotes() =>
      FirebaseFirestore.instance
          .collection('user')
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => NoteItem.fromJson(doc.data()))
              .toList());
}
