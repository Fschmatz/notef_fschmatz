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
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      elevation: 3.0,
      title: const Text(
        "Error",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      content: Text(
        checkProblems(),
        style: const TextStyle(
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
    return Scaffold(
        appBar: AppBar(
          title: const Text("New Note"),
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
              child: IconButton(
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
            ),
          ],
        ),
        body: ListView(children: [
          ListTile(
            leading: const SizedBox(
              height: 0.1,
            ),
            title: Text("Title".toUpperCase(),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).accentTextTheme.headline1!.color)),
          ),
          ListTile(
            leading: const Icon(Icons.notes_outlined),
            title: TextField(
              autofocus: true,
              minLines: 1,
              maxLines: 2,
              maxLength: 50,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              controller: customControllerTitle,
              decoration: InputDecoration(
                focusColor: Theme.of(context).accentColor,
                helperText: "* Required",
              ),
              style: const TextStyle(
                fontSize: 17,
              ),
            ),
          ),
          ListTile(
            leading: const SizedBox(
              height: 0.1,
            ),
            title: Text("Note".toUpperCase(),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).accentTextTheme.headline1!.color)),
          ),
          ListTile(
            leading: const Icon(Icons.article_outlined),
            title: TextField(
              minLines: 1,
              maxLines: 12,
              maxLength: 200,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              controller: customControllerText,
              decoration: InputDecoration(
                focusColor: Theme.of(context).accentColor,
              ),
              style: const TextStyle(
                fontSize: 17,
              ),
            ),
          ),
        ]));
  }
}
