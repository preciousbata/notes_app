import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

NoteItem notesFromJson(String str) =>
    NoteItem.fromJson(json.decode(str));

String notesToJson(NoteItem data) =>
    json.encode(data.toJson());

class NoteItem {
  String id;
  String title;
  String content;
  DateTime createdAt;
  String color;

  NoteItem({
    this.id = '',
    required this.title,
    required this.content,
    required this.createdAt,
    this.color = '',
  });

  factory NoteItem.fromJson(Map<String, dynamic> json) =>
      NoteItem(
          id: json["id"],
          title: json["title"],
          content: json["content"],
          createdAt:
              (json["createdAt"] as Timestamp).toDate(),
          color: json["color"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "createdAt": createdAt,
        "color": color
      };
}
