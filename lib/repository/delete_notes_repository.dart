import 'package:cloud_firestore/cloud_firestore.dart';

class DeleteNoteRepository  {
   static Future deleteNotes(String id) async {
    final note =
    FirebaseFirestore.instance.collection('user').doc(id);
    note.delete();
  }
}