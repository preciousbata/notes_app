import 'package:flutter/material.dart';
import 'package:notes_app/firestore_database_service.dart';
import 'package:notes_app/model/note_item_model.dart';
import 'package:notes_app/repository/note_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import '../repository/archive_note_repository.dart';
import '../widgets/archive_list.dart';
import '../widgets/sliver_app_bar.dart';

class ArchivedNotesScreen extends StatefulWidget {
  static String routeName = '/archivedNotes';

  const ArchivedNotesScreen({Key? key}) : super(key: key);

  @override
  State<ArchivedNotesScreen> createState() => _ArchivedNoteState();
}

class _ArchivedNoteState extends State<ArchivedNotesScreen> {
  final archiveNoteRepository = ArchiveNoteRepository(NoteRepository(FirestoreDatabaseService(FirebaseFirestore.instance)),FirestoreDatabaseService(FirebaseFirestore.instance));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<NoteItem>>(
        stream: archiveNoteRepository.archiveNotes,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong!');
          } else if (snapshot.hasData) {
            final notes = snapshot.data!;
            notes.sort((a, b) => b.createdAt.compareTo(a.createdAt));
            return CustomScrollView(
              slivers: [
                const AppSliverAppBar(
                  titleText: 'Archived Notes',
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(10.0),
                  sliver: ArchivedList(
                    notes: notes,
                    onDeleteNote: (note) => archiveNoteRepository.deleteNoteFromArchive(note),
                    onRestoreNote: (note) => {debugPrint('note to archive is $note'), archiveNoteRepository.restoreNote(note)},
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
