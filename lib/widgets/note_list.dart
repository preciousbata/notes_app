import 'package:flutter/material.dart';
import 'package:notes_app/model/note_item.dart';

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
      delegate:
          SliverChildBuilderDelegate((context, index) {
        final note = notes[index];
        return NoteListItem(
          note: note,
          onPressed: (note) {},
        );
      }, childCount: notes.length),
    );
  }
}

class NoteListItem extends StatelessWidget {
  final NoteItem note;
  final void Function(NoteItem) onPressed;
  const NoteListItem({
    Key? key,
    required this.note,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(note),
      child: Card(
        color: Colors.blue,
        elevation: 3,
        child: Dismissible(
          key: ValueKey('dismissable-$note.id'),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                SizedBox(
                  width: 100.0,
                  height: double.infinity,
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 25.0,
                  ),
                )
              ],
            ),
          ),
          onDismissed: (_) {
            debugPrint('ondissimed called');
          },
          confirmDismiss: (_) async {
            showConfrimation(context,
                title: 'Are you sure?',
                content: 'You want to delete this note?');
            return null;
          },
          child: Container(
            height: 100.0,
            color: Colors.greenAccent,
            padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 10.0),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        note.title,
                        maxLines: 2,
                        style: const TextStyle(
                          overflow: TextOverflow.fade,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        note.content,
                        maxLines: 5,
                        style: const TextStyle(
                            overflow:
                                TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.calendar_month,
                        size: 12,
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Text(
                        note.createdAt.toString(),
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
