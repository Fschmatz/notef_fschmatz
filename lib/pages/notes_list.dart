import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:notef_fschmatz/classes/note.dart';
import 'package:notef_fschmatz/widgets/note_card.dart';

import '../redux/app_state.dart';
import '../redux/selectors.dart';

class NotesList extends StatefulWidget {
  @override
  State<NotesList> createState() => _NotesListState();

  const NotesList({super.key});
}

class _NotesListState extends State<NotesList> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<Note>>(
      converter: (store) {
        return selectNotes();
      },
      builder: (context, notes) {
        return notes.isEmpty
            ? const Center(
                child: Text(
                '...',
                style: TextStyle(fontSize: 18),
              ))
            : ListView(physics: const AlwaysScrollableScrollPhysics(), children: [
                ListView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    return NoteCard(note: notes[index]);
                  },
                ),
                const SizedBox(
                  height: 100,
                ),
              ]);
      },
    );
  }
}
