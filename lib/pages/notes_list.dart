import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:notef_fschmatz/entity/note.dart';
import 'package:notef_fschmatz/widgets/note_card.dart';

import '../redux/app_state.dart';
import '../redux/selectors.dart';
import '../util/widget/segmented_widget_list.dart';

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
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: notes.isEmpty
              ? const Center(
                  child: Text(
                  '...',
                  style: TextStyle(fontSize: 18),
                ))
              : ListView(padding: const EdgeInsets.only(bottom: 75), physics: const AlwaysScrollableScrollPhysics(), children: [
                  SegmentedWidgetList(
                    children: notes
                        .map(
                          (note) => NoteCard(key: ValueKey(note.id), note: note),
                        )
                        .toList(),
                  ),
                ]),
        );
      },
    );
  }
}
