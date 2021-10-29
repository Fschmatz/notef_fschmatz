import 'package:flutter/material.dart';
import 'package:notef_fschmatz/classes/note.dart';
import 'package:notef_fschmatz/db/note_dao.dart';
import 'package:notef_fschmatz/pages/edit_note.dart';

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
              topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Wrap(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.edit_outlined,
                        color: Theme.of(context).hintColor),
                    title: const Text(
                      "Edit note",
                      style: TextStyle(fontSize: 16),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => EditNote(
                              noteEdit: widget.note,
                              dismissNotification: widget.dismissNotification,
                              createNotification: widget.createNotification,
                            ),
                            fullscreenDialog: true,
                          )).then((value) => widget.refreshHome());
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: Icon(Icons.delete_outline_outlined,
                        color: Theme.of(context).hintColor),
                    title: const Text(
                      "Delete note",
                      style: TextStyle(fontSize: 16),
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
    Widget okButton = TextButton(
      child: Text(
        "Yes",
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).accentColor),
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
    );

    AlertDialog alert = AlertDialog(
      elevation: 3.0,
      title: const Text(
        "Confirm", //
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      ),
      content: const Text(
        "\nDelete ?",
        style: TextStyle(
          fontSize: 18,
        ),
      ),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: openBottomMenu,
          child: Column(
            children: <Widget>[
              ListTile(
                contentPadding: const EdgeInsets.fromLTRB(16, 0, 5, 0),
                title: Text(widget.note.title!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: widget.note.pinned == 1
                          ? Theme.of(context).accentTextTheme.headline1!.color
                          : Theme.of(context).textTheme.headline6!.color,
                    )),
                trailing: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                  child: SizedBox(
                    width: 55,
                    child: TextButton(
                      onPressed: () {
                        _pinAndUnpinNotification();
                        widget.refreshHome();
                      },
                      child: Icon(
                        Icons.push_pin_outlined,
                        color: widget.note.pinned == 1
                            ? Theme.of(context).accentTextTheme.headline1!.color
                            : Theme.of(context).textTheme.headline6!.color,
                      ),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: widget.note.pinned == 1
                            ? Theme.of(context).accentColor.withOpacity(0.4)
                            : null,
                        onPrimary: Theme.of(context).accentColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: widget.note.text!.isNotEmpty,
                child: ListTile(
                  contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                  title: Text(
                    widget.note.text!,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context)
                          .textTheme
                          .headline6!
                          .color!
                          .withOpacity(0.8),
                    ),
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
