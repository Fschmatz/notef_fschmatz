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
  TextEditingController customControllerTitle = TextEditingController();
  TextEditingController customControllerText = TextEditingController();

  void _saveNote() async {
    Map<String, dynamic> row = {
      NoteDao.columnTitle: customControllerTitle.text,
      NoteDao.columnText: customControllerText.text,
      NoteDao.columnPinned: 1
    };
    final id = await dbNotes.insert(row);
    widget.createNotification(
      id,
      customControllerTitle.text,
      customControllerText.text,
    );
  }

  String checkProblems() {
    String errors = "";
    if (customControllerTitle.text.isEmpty) {
      errors += "Note is empty\n";
    }
    return errors;
  }

  showAlertDialogErrors(BuildContext context) {
    Widget okButton = TextButton(
      child: const Text(
        "Ok",
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    AlertDialog alert = AlertDialog(
      title: const Text(
        "Error",
      ),
      content: Text(
        checkProblems(),
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
    return Scaffold(
        appBar: AppBar(
          title: const Text("New Note"),
          actions: [
            IconButton(
              icon: const Icon(Icons.save_outlined),
              tooltip: 'Save',
              onPressed: () {
                if (checkProblems().isEmpty) {
                  _saveNote();
                  Navigator.of(context).pop();
                } else {
                  showAlertDialogErrors(context);
                }
              },
            ),
          ],
        ),
        body: ListView(children: [
          ListTile(
            title: Text("Title",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.primary)),
          ),
          ListTile(
            title: TextField(
              autofocus: true,
              minLines: 1,
              maxLines: 2,
              maxLength: 50,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              textCapitalization: TextCapitalization.sentences,
              controller: customControllerTitle,
              decoration: InputDecoration(
                focusColor: Theme.of(context).colorScheme.primary,
                helperText: "* Required",
                prefixIcon: const Icon(
                  Icons.notes_outlined,
                ),
              ),
            ),
          ),
          ListTile(
            title: Text("Note",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.primary)),
          ),
          ListTile(
            title: TextField(
              minLines: 1,
              maxLines: 5,
              maxLength: 200,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              textCapitalization: TextCapitalization.sentences,
              controller: customControllerText,
              decoration: InputDecoration(
                focusColor: Theme.of(context).colorScheme.primary,
                prefixIcon: const Icon(
                  Icons.article_outlined,
                ),
              ),
            ),
          ),
        ]));
  }
}
