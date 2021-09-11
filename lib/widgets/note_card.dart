import 'package:flutter/material.dart';
import 'package:notef_fschmatz/classes/note.dart';
import 'package:notef_fschmatz/db/note_dao.dart';

class NoteCard extends StatefulWidget {
  @override
  _NoteCardState createState() => _NoteCardState();

  Note note;
  Function() refreshHome;

  NoteCard({Key? key, required this.note, required this.refreshHome})
      : super(key: key);
}

class _NoteCardState extends State<NoteCard> {

  Future<void> _delete() async {
    final dbDayNotes = NoteDao.instance;
    final deleted = await dbDayNotes.delete(widget.note.id!);
  }

  Future<void> _changeStarredStatus() async {
    final dbDayNotes = NoteDao.instance;
    Map<String, dynamic> row = {
      NoteDao.columnId: widget.note.id,
      NoteDao.columnPinned: widget.note.pinned == 0 ? 1 : 0,
    };
    final update = await dbDayNotes.update(row);
  }

  void openBottomMenu() {
    showModalBottomSheet(
        shape:  const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft:  Radius.circular(25.0),
              topRight: Radius.circular(25.0)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.edit_outlined,
                      color: Theme.of(context).hintColor),
                  title:  const Text(
                    "Edit note",
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                   /* Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder:
                              (BuildContext context) =>
                              EditNote(
                                  dayNoteEdit:
                                  widget.note),
                          fullscreenDialog: true,
                        ))
                        .then(
                            (value) => widget.refreshHome());*/
                  },
                ),
                const Divider(),
                ListTile(
                  leading: Icon(Icons.delete_outline_outlined,
                      color: Theme.of(context).hintColor),
                  title:  const Text(
                    "Delete note",
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    showAlertDialogOkDelete(context);
                  },
                ),
              ],
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
        widget.refreshHome();
      },
    );

    AlertDialog alert = AlertDialog(
      elevation: 3.0,
      title:  const Text(
        "Confirm", //
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      ),
      content:  const Text(
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
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: openBottomMenu,
          child: Column(
            children: <Widget>[
              ListTile(
                contentPadding: const EdgeInsets.fromLTRB(16, 0, 5, 0),
                title: Text('widget.note.text!',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context)
                            .accentTextTheme
                            .headline1!
                            .color)),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    widget.note.pinned == 0
                        ? IconButton(
                            icon:  const Icon(
                              Icons.push_pin_outlined,
                            ),
                            onPressed: () {
                              _changeStarredStatus();
                              widget.refreshHome();
                            },
                          )
                        : IconButton(
                            icon: Icon(
                              Icons.star_border_outlined,
                              color: Theme.of(context).accentColor,
                            ),
                            onPressed: () {
                              _changeStarredStatus();
                              widget.refreshHome();
                            },
                          ),
                  ],
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                title: Text(
                  widget.note.text!,
                  style:  const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
