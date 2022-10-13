import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_app/model/note_item_model.dart';

class CreateNote {
  Future createNotes(NoteItem note) async {
    final collection =
        FirebaseFirestore.instance.collection('user').doc();
    note.id = collection.id;
    note.createdAt =
        DateTime.parse(DateTime.now().toString());
    final json = note.toJson();
    await collection.set(json);
  }
}
