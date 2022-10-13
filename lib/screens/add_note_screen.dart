import 'package:flutter/material.dart';
import 'package:notes_app/model/note_item_model.dart';
import 'package:notes_app/repository/create_note_repository.dart';

class AddNoteScreen extends StatefulWidget {
  static String routeName = '/add_note';
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  State<AddNoteScreen> createState() =>
      _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final dateController = TextEditingController();
  final createNote = CreateNote();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.fromLTRB(25, 100, 25, 0),
          child: SingleChildScrollView(
            child: Expanded(
              child: Column(
                children: [
                  const Text(
                    'Create New Note',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  customTextField(
                      hintTitle: 'Title',
                      controller: titleController,
                      maxLine: 1,
                      value: TextInputType.text),
                  const SizedBox(
                    height: 30,
                  ),
                  customTextField(
                      hintTitle: 'Content',
                      controller: contentController,
                      maxLine: 6,
                      value: TextInputType.multiline),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        final note = NoteItem(
                            title: titleController.text,
                            content: contentController.text,
                            createdAt: DateTime.now());
                        createNote.createNotes(note);
                        final snackBar = SnackBar(
                          content: const Text(
                              'Note Created Successfully'),
                          backgroundColor: (Colors.black12),
                          action: SnackBarAction(
                            label: 'dismiss',
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context)
                            .showSnackBar(snackBar);
                        Navigator.pop(context);
                      },
                      child: const Text('Create New Note'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget customTextField(
      {required String hintTitle,
      required TextEditingController controller,
      required TextInputType value,
      required int maxLine}) {
    return TextField(
      controller: controller,
      maxLines: maxLine,
      keyboardType: value,
      decoration: InputDecoration(
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12)),
          fillColor: Colors.white,
          hintText: hintTitle,
          contentPadding: const EdgeInsets.symmetric(
              vertical: 7, horizontal: 10)),
    );
  }
}
