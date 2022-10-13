import 'package:flutter/material.dart';
import 'package:notes_app/model/note_item_model.dart';
import 'package:notes_app/repository/read_notes_repository.dart';
import 'package:notes_app/screens/add_note_screen.dart';
import 'package:notes_app/widgets/app_icon_button.dart';

import '../widgets/note_list.dart';
import '../widgets/sliver_app_bar.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final readNotes = ReadNote().readNotes();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<NoteItem>>(
            stream: readNotes,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong!');
              } else if (snapshot.hasData) {
                final notes = snapshot.data!;
                notes.sort((a,b) => b.createdAt.compareTo(a.createdAt));
                return CustomScrollView(
                  slivers: [
                    const AppSliverAppBar(
                      titleText: 'Note App',
                      icon: Icons.edit,
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.all(10.0),
                      sliver: NoteList(
                        notes: notes,
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, AddNoteScreen.routeName),
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AppIcon(
                press: () {},
                icon: Icons.table_chart_outlined,
              ),
              AppIcon(
                press: () {},
                icon: Icons.brightness_4,
              )
            ],
          ),
        ),
      ),
    );
  }
}
