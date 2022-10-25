import 'package:flutter/material.dart';
import 'package:notes_app/model/note_item_model.dart';

import '../repository/archive_note_repository.dart';
import '../widgets/note_grid.dart';
import '../widgets/note_list.dart';
import '../widgets/sliver_app_bar.dart';

class ArchivedNotes extends StatefulWidget {
  static String routeName = '/archivedNotes';
  const ArchivedNotes({Key? key}) : super(key: key);

  @override
  State<ArchivedNotes> createState() => _ArchivedNoteState();
}

class _ArchivedNoteState extends State<ArchivedNotes> {
  final archiveNoteRepository = ArchiveNoteRepository();

  // @override
  // void initState() {
  //   super.initState();
  //   archiveNoteRepository.archiveNotes.listen((archiveNotes) {
  //     //debugPrint('archiveNotes are $archiveNotes');
  //   });
  // }

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
                  sliver:
                  // NoteGrid(notes: notes),
                  NoteList(
                    notes: notes,
                    onDeleteNote: (note) => archiveNoteRepository.deleteNoteFromArchive(note),
                    onArchiveNote: (note) => {
                      debugPrint('note to archive is $note'),
                      archiveNoteRepository.saveNoteToArchive(note)
                    },
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
