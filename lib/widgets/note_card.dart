import 'package:flutter/material.dart';
import 'package:notef_fschmatz/classes/note.dart';

import '../service/note_service.dart';
import 'dialog_store_note.dart';

class NoteCard extends StatefulWidget {
  @override
  State<NoteCard> createState() => _NoteCardState();

  final Note note;

  const NoteCard({Key? key, required this.note}) : super(key: key);
}

class _NoteCardState extends State<NoteCard> {
  final NoteService noteService = NoteService();

  Future<void> _pinAndUnpinNotification() async {
    if (widget.note.isPinned()) {
      noteService.dismissNotification(widget.note.id!);
    } else {
      noteService.createNotification(widget.note.id!, widget.note.title!, widget.note.text!);
    }

    noteService.changeState(widget.note);
  }

  Future<void> _delete() async {
    noteService.delete(widget.note);
    Navigator.of(context).pop();
  }

  _openDialogDelete() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Confirm",
          ),
          content: const Text(
            "Delete ?",
          ),
          actions: [
            TextButton(
              child: const Text(
                "Yes",
              ),
              onPressed: () {
                _delete();
              },
            )
          ],
        );
      },
    );
  }

  _openDialogEdit() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return DialogStoreNote(note: widget.note);
        });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.fromLTRB(10, 4, 10, 4),
      child: InkWell(
        onTap: () => _openDialogEdit(),
        onLongPress: () => _openDialogDelete(),
        borderRadius: BorderRadius.circular(12),
        child: Column(
          children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(16, widget.note.text!.isNotEmpty ? 5 : 0, 10, widget.note.text!.isNotEmpty ? 5 : 0),
              title: Text(
                widget.note.title!,
              ),
              subtitle: widget.note.text!.isNotEmpty
                  ? Text(
                      widget.note.text!,
                      style: TextStyle(fontSize: 14, color: theme.hintColor),
                    )
                  : null,
              trailing: SizedBox(
                width: 60,
                child: TextButton(
                  onPressed: () {
                    _pinAndUnpinNotification();
                  },
                  child: Icon(
                    Icons.push_pin_outlined,
                    color: widget.note.isPinned() ? theme.colorScheme.onTertiaryContainer : null,
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: widget.note.isPinned() ? theme.colorScheme.tertiaryContainer : null,
                      elevation: 0,
                      shape: const StadiumBorder()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
