import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../db/note_dao.dart';

class DialogNewNote extends StatefulWidget {
  Function(int, String, String) createNotification;

  DialogNewNote({Key? key, required this.createNotification}) : super(key: key);

  @override
  _DialogNewNoteState createState() => _DialogNewNoteState();
}

class _DialogNewNoteState extends State<DialogNewNote> {
  final dbNotes = NoteDao.instance;
  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerNote = TextEditingController();
  bool _validTitle = true;

  void _saveNote() async {
    Map<String, dynamic> row = {NoteDao.columnTitle: controllerTitle.text, NoteDao.columnText: controllerNote.text, NoteDao.columnPinned: 1};
    final id = await dbNotes.insert(row);

    widget.createNotification(
      id,
      controllerTitle.text,
      controllerNote.text,
    );
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
      title: const Text('New'),
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
                      border: const OutlineInputBorder(),
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
                      border: OutlineInputBorder(),
                      counterText: "",
                    )),
              ),
            ],
          )),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel')),
        TextButton(
            onPressed: () {
              if (validateTextFields()) {
                _saveNote();
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
