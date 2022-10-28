import 'package:flutter/material.dart';
import 'package:notes_app/constant.dart';
import 'package:notes_app/model/note_item_model.dart';

class NoteDetailScreen extends StatefulWidget {
  static String routeName = '/note_detail';

  const NoteDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as NoteItem;
    return Scaffold(
      appBar: AppBar(
        title: Text(args.title.toUpperCase()),
        centerTitle: true,
        actions: const [
          IconButton(onPressed: null, icon: Icon(Icons.edit))
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(args.content, style: const TextStyle(fontSize: 20),))
    );
  }
}
