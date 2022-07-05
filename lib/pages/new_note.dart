import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notef_fschmatz/db/note_dao.dart';

class NewNote extends StatefulWidget {
  Function(int, String, String) createNotification;

  NewNote({Key? key, required this.createNotification}) : super(key: key);

  @override
  _NewNoteState createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  final dbNotes = NoteDao.instance;
  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerNote = TextEditingController();
  bool _validTitle = true;

  void _saveNote() async {
    Map<String, dynamic> row = {
      NoteDao.columnTitle: controllerTitle.text,
      NoteDao.columnText: controllerNote.text,
      NoteDao.columnPinned: 1
    };
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
    return Scaffold(
        appBar: AppBar(
          title: const Text("New Note"),
          actions: [
            IconButton(
              icon: const Icon(Icons.save_outlined),
              tooltip: 'Save',
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
            ),
          ],
        ),
        body: ListView(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
        ]));
  }
}
