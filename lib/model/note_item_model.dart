import 'package:cloud_firestore/cloud_firestore.dart';

class NoteItem {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;
  final String colorHex;
  String referenceId;

  NoteItem({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    this.referenceId = '',
    this.colorHex = '',
  });

  factory NoteItem.fromJson(Map<String, dynamic> json) => NoteItem(
      id: json["id"],
      title: json["title"],
      content: json["content"],
      createdAt: (json["createdAt"] as Timestamp).toDate(),
      colorHex: json["color"],
      referenceId: json['referenceId'] ?? '');

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "createdAt": createdAt,
        "color": colorHex,
        "referenceId": referenceId,
      };

  @override
  String toString() {
    return 'NoteItem{id: $id, title: $title, content: $content, createdAt: $createdAt, colorHex: $colorHex}';
  }
}
