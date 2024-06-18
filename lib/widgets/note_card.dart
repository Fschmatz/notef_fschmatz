import 'package:flutter/material.dart';
import 'package:notef_fschmatz/classes/note.dart';
import 'package:notef_fschmatz/db/note_dao.dart';
import 'package:notef_fschmatz/widgets/dialog_edit_note.dart';

class NoteCard extends StatefulWidget {
  @override
  _NoteCardState createState() => _NoteCardState();

  Note note;
  Function() refreshHome;
  Function(int, String, String) createNotification;
  Function(int) dismissNotification;

  NoteCard({Key? key, required this.note, required this.refreshHome, required this.createNotification, required this.dismissNotification})
      : super(key: key);
}

class _NoteCardState extends State<NoteCard> {
  Future<void> _delete() async {
    final dbDayNotes = NoteDao.instance;
    await dbDayNotes.delete(widget.note.id!);
  }

  Future<void> _pinAndUnpinNotification() async {
    if (widget.note.pinned == 0) {
      widget.createNotification(widget.note.id!, widget.note.title!, widget.note.text!);
    } else {
      widget.dismissNotification(widget.note.id!);
    }
    _changeState();
  }

  Future<void> _changeState() async {
    final dbNotes = NoteDao.instance;
    Map<String, dynamic> row = {
      NoteDao.columnId: widget.note.id,
      NoteDao.columnPinned: widget.note.pinned == 0 ? 1 : 0,
    };
    await dbNotes.update(row);
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
                Navigator.of(context).pop();
                _delete();
                if (widget.note.pinned == 1) {
                  widget.dismissNotification(widget.note.id!);
                }
                widget.refreshHome();
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
          return DialogEditNote(
            noteEdit: widget.note,
            createNotification: widget.createNotification,
            dismissNotification: widget.dismissNotification,
          );
        }).then((_) => widget.refreshHome());
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
                    widget.refreshHome();
                  },
                  child: Icon(
                    Icons.push_pin_outlined,
                    color: widget.note.pinned == 1 ? theme.colorScheme.onTertiaryContainer : null,
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: widget.note.pinned == 1 ? theme.colorScheme.tertiaryContainer : null,
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
