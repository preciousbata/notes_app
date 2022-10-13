import 'package:flutter/material.dart';
import 'package:notes_app/model/note_item_model.dart';

class NoteGrid extends StatelessWidget {
  final List<NoteItem> notes;
  const NoteGrid({
    Key? key,
    required this.notes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate:
          SliverChildBuilderDelegate((context, index) {
        return const NoteGridItem();
      }, childCount: 10),
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10.0,
              childAspectRatio: 0.8,
              crossAxisSpacing: 10.0),
    );
  }
}

class NoteGridItem extends StatelessWidget {
  const NoteGridItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        color: Colors.red,
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 15, vertical: 10.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0)),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.start,
                  children: const [
                    Text(
                      'title',
                      maxLines: 3,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.fade),
                    ),
                    Text(
                      'content',
                      maxLines: 5,
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.calendar_month,
                    size: 12,
                  ),
                  Text(
                    'date',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
