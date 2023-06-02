import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:notef_fschmatz/classes/note.dart';
import 'package:notef_fschmatz/db/note_dao.dart';

class DialogEditNote extends StatefulWidget {
  Note noteEdit;
  Function(int, String, String) createNotification;
  Function(int) dismissNotification;

  DialogEditNote(
      {Key? key,
      required this.noteEdit,
      required this.createNotification,
      required this.dismissNotification})
      : super(key: key);

  @override
  _DialogEditNoteState createState() => _DialogEditNoteState();
}

class _DialogEditNoteState extends State<DialogEditNote> {
  final dbNotes = NoteDao.instance;
  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerNote = TextEditingController();
  bool _validTitle = true;

  @override
  void initState() {
    super.initState();
    controllerTitle.text = widget.noteEdit.title!;
    controllerNote.text = widget.noteEdit.text!;
  }

  void _updateNote() async {
    if (widget.noteEdit.pinned == 1) {
      widget.dismissNotification(widget.noteEdit.id!);
    }
    Map<String, dynamic> row = {
      NoteDao.columnId: widget.noteEdit.id,
      NoteDao.columnTitle: controllerTitle.text,
      NoteDao.columnText: controllerNote.text,
      NoteDao.columnPinned: 1
    };
    widget.createNotification(
      widget.noteEdit.id!,
      controllerTitle.text,
      controllerNote.text,
    );
    final update = await dbNotes.update(row);
  }

  bool validateTextFields() {
    if (controllerTitle.text.isEmpty) {
      _validTitle = false;
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit'),
      content: SizedBox(
          width: 280.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                child: TextField(
                  autofocus: true,
                  minLines: 1,
                  maxLines: 2,
                  maxLength: 50,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  textCapitalization: TextCapitalization.sentences,
                  controller: controllerTitle,
                  decoration: InputDecoration(
                      labelText: "Title",
                      helperText: "* Required",
                      counterText: "",
                      errorText: (_validTitle) ? null : "Title is empty"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: TextField(
                    minLines: 1,
                    maxLines: 3,
                    maxLength: 200,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    textCapitalization: TextCapitalization.sentences,
                    controller: controllerNote,
                    decoration: const InputDecoration(
                      labelText: "Note",
                      counterText: "",
                    )),
              ),
            ],
          )),
      actions: [
        TextButton(
            onPressed: () {
              // Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('Cancel')),
        TextButton(
            onPressed: () {
              if (validateTextFields()) {
                _updateNote();
                // Navigator.of(context).pop();
                Navigator.of(context).pop();
              } else {
                setState(() {
                  _validTitle;
                });
              }
            },
            child: const Text('Save'))
      ],
    );
  }
}
