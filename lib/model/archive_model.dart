import 'package:cloud_firestore/cloud_firestore.dart';

class Archive {
  String id;
  String content;


  Archive({
    this.id = '',
    required this.content,
  });


  Map<String, dynamic> toJson(DocumentReference<Map<String, dynamic>> note) => {
    "id": id,
    "content": content,
  };
}