import 'package:flutter/material.dart';
import 'package:notes_app/firestore_database_service.dart';
import 'package:notes_app/model/note_item_model.dart';
import 'package:notes_app/repository/archive_note_repository.dart';
import 'package:notes_app/repository/note_repository.dart';
import 'package:notes_app/screens/add_note_screen.dart';
import 'package:notes_app/screens/archived_note_screen.dart';
import 'package:notes_app/widgets/app_icon_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import '../widgets/note_page_view.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final noteRepository = NoteRepository(FirestoreDatabaseService(FirebaseFirestore.instance));
  final archiveNoteRepository = ArchiveNoteRepository(
    NoteRepository(FirestoreDatabaseService(FirebaseFirestore.instance)), FirestoreDatabaseService(FirebaseFirestore.instance)
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white24,
      body: StreamBuilder<List<NoteItem>>(
        stream: noteRepository.notes,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong!');
          } else if (snapshot.hasData) {
            final notes = snapshot.data!;
            notes.sort((a, b) =>
                b.createdAt.compareTo(a.createdAt));
            return NotePageView(
              notes: notes,
              onDeleteNote: (note) => noteRepository
                  .deleteNote(note.referenceId),
              onArchiveNote: (note) => {
                debugPrint('note to archive is $note'),
                archiveNoteRepository
                    .saveNoteToArchive(note)
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(
            context, AddNoteScreen.routeName),
        elevation: 0,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: SizedBox(
          height: 50.0,
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceAround,
            children: [
              AppIcon(
                press: () {},
                icon: Icons.brightness_4_outlined,
              ),
              AppIcon(
                press: () => Navigator.pushNamed(
                    context, ArchivedNotesScreen.routeName),
                icon: Icons.archive_rounded,
              )
            ],
          ),
        ),
      ),
    );
  }
}
