import 'package:flutter/material.dart';
import 'package:notes_app/repository/note_repository.dart';

import '../utils/hex_conversion.dart';

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
  final noteRepository = NoteRepository();

  String _selectedColor = '';
  String text = '';
  bool onPressed = false;

  final colors = [
    '000000',
    '9F2B68',
    'BF40BF',
    '00FF00',
    '454B1B',
  ];

  String? get errorText {
    final text = titleController.value.text;
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    return null;
  }

  void _createNote(String title, String content) {
    setState(() {
      onPressed = true;
    });
    if (errorText == null) {
      noteRepository.createNote(
          title, content, _selectedColor);
      final snackBar = SnackBar(
        content: const Text('Note Created Successfully'),
        backgroundColor: (Colors.black12),
        action: SnackBarAction(
          label: 'dismiss',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pop(context);
    }
  }

  Widget buildColorContainer(String hex) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: HexColor(hex),
        shape: BoxShape.circle,
      ),
      child: _selectedColor == hex
          ? const Center(
              child: Icon(Icons.check, color: Colors.amber))
          : const SizedBox.shrink(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.fromLTRB(25, 100, 25, 0),
          child: SingleChildScrollView(
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
                    errortext: errorText,
                    value: TextInputType.text,
                    onchanged: (_) => setState(() {})),
                const SizedBox(
                  height: 30,
                ),
                customTextField(
                    hintTitle: 'Content',
                    controller: contentController,
                    maxLine: 6,
                    errortext: null,
                    onchanged: (_) => null,
                    value: TextInputType.multiline),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Pick a Note Colour',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18),
                    ),
                    SizedBox(
                      height: 100,
                      child: ListView.separated(
                        separatorBuilder: (_, __) =>
                            const SizedBox(width: 20),
                        scrollDirection: Axis.horizontal,
                        itemCount: colors.length,
                        itemBuilder: (_, int index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedColor =
                                    colors[index];
                                debugPrint(
                                    'selected color is $_selectedColor');
                              });
                            },
                            child: buildColorContainer(
                                colors[index]),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    final String title =
                        titleController.text.trim();
                    final String content =
                        contentController.text.trim();
                    title.isNotEmpty
                        ? _createNote(title, content)
                        : null;
                  },
                  child: const Text('Create New Note'),
                ),
              ],
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
      required onchanged,
      required String? errortext,
      required int maxLine}) {
    return TextField(
      controller: controller,
      maxLines: maxLine,
      keyboardType: value,
      onChanged: (_) => onchanged,
      decoration: InputDecoration(
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12)),
          fillColor: Colors.white,
          hintText: hintTitle,
          errorText: onPressed ? errortext : null,
          contentPadding: const EdgeInsets.symmetric(
              vertical: 7, horizontal: 10)),
    );
  }
}
