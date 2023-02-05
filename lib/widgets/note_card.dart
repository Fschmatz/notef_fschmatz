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

  NoteCard(
      {Key? key,
      required this.note,
      required this.refreshHome,
      required this.createNotification,
      required this.dismissNotification})
      : super(key: key);
}

class _NoteCardState extends State<NoteCard> {
  Future<void> _delete() async {
    final dbDayNotes = NoteDao.instance;
    final deleted = await dbDayNotes.delete(widget.note.id!);
  }

  Future<void> _pinAndUnpinNotification() async {
    if (widget.note.pinned == 0) {
      widget.createNotification(
          widget.note.id!, widget.note.title!, widget.note.text!);
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
    final update = await dbNotes.update(row);
  }

  void openBottomMenu() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0), topRight: Radius.circular(25.0)),
        ),
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Wrap(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      widget.note.title!,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.edit_outlined),
                    title: const Text(
                      "Edit",
                    ),
                    onTap: ()
                       => showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DialogEditNote(
                            noteEdit: widget.note,
                            createNotification:  widget.createNotification,
                            dismissNotification: widget.dismissNotification,
                        );
                      }).then((_) => widget.refreshHome()),
                  ),
                  ListTile(
                    leading: const Icon(Icons.delete_outline_outlined),
                    title: const Text(
                      "Delete",
                    ),
                    onTap: () {
                      showAlertDialogOkDelete(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  showAlertDialogOkDelete(BuildContext context) {
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: openBottomMenu,
          child: Column(
            children: <Widget>[
              ListTile(
                contentPadding: EdgeInsets.fromLTRB(
                    16,
                    widget.note.text!.isNotEmpty ? 5 : 0,
                    10,
                    widget.note.text!.isNotEmpty ? 5 : 0),
                title: Text(
                  widget.note.title!,
                ),
                subtitle: widget.note.text!.isNotEmpty
                    ? Text(
                        widget.note.text!,
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor
                        ),
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
                      color: widget.note.pinned == 1
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).textTheme.headline6!.color,
                    ),
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: widget.note.pinned == 1
                            ? Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.4)
                            : null,
                        onPrimary: Theme.of(context)
                            .textTheme
                            .headline6!
                            .color!
                            .withOpacity(0.8),
                        shape: const StadiumBorder()),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
