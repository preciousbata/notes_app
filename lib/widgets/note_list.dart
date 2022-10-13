import 'package:flutter/material.dart';
import 'package:notes_app/model/archive_model.dart';
import 'package:notes_app/model/note_item_model.dart';
import 'package:notes_app/repository/archive_note_repository.dart';

import '../repository/delete_notes_repository.dart';
import '../utils/dialog.dart';

class NoteList extends StatelessWidget {
  final List<NoteItem> notes;

  const NoteList({
    Key? key,
    required this.notes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final note = notes[index];
        return NoteListItem(
          note: note,
          onPressed: (note) {},
        );
      }, childCount: notes.length),
    );
  }
}

class NoteListItem extends StatefulWidget {
  final NoteItem note;
  final void Function(NoteItem) onPressed;

  const NoteListItem({
    Key? key,
    required this.note,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<NoteListItem> createState() => _NoteListItemState();
}

class _NoteListItemState extends State<NoteListItem> {
  late String whatHappened;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onPressed(widget.note),
      child: Card(
        color: Colors.blue,
        elevation: 3,
        child: Dismissible(
          key: ValueKey(widget.note.id),
          // direction: DismissDirection.endToStart,
          secondaryBackground: Container(
            color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children:  [
                SizedBox(
                  width: 100.0,
                  height: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 25.0,
                      ),
                      Text('Delete', style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),),
                    ],
                  ),
                )
              ],
            ),
          ),
          background: Container(
            color: Colors.green,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children:  [
                SizedBox(
                  width: 100.0,
                  height: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.archive_rounded,
                        color: Colors.white,
                        size: 25.0,
                      ),
                      Text('Archive', style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),),
                    ],
                  ),
                )
              ],
            ),
          ),

          onDismissed: (direction) {
            switch(direction){
              case DismissDirection.endToStart:
                DeleteNoteRepository.deleteNotes(widget.note.id);
                break;
              case DismissDirection.startToEnd:
                ArchiveNote.archiveNotes(widget.note.id, Archive(content: ));
                break;
              default:
                break;
            }
          },
          confirmDismiss: (DismissDirection dismissDirection) async {
            switch (dismissDirection) {
              case DismissDirection.endToStart:
                whatHappened = 'DELETED';
                return await showConfirmationDialog(context, 'delete') ==
                    true;
              case DismissDirection.startToEnd:
                whatHappened = 'ARCHIVED';
                return await showConfirmationDialog(context, 'archive') == true;
              default:
              assert(false);
                break;
            }
            return false;
          },
          child: Container(
            height: 100.0,
            color: Colors.blueGrey,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        widget.note.title,
                        maxLines: 2,
                        style: const TextStyle(
                          overflow: TextOverflow.fade,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        widget.note.content,
                        maxLines: 5,
                        softWrap: true,
                        style: const TextStyle(overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.calendar_month,
                        size: 12,
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Text(
                        widget.note.createdAt.toString(),
                        style: const TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
