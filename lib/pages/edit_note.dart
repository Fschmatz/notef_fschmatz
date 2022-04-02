import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:notef_fschmatz/classes/note.dart';
import 'package:notef_fschmatz/db/note_dao.dart';

class EditNote extends StatefulWidget {
  Note noteEdit;
  Function(int, String, String) createNotification;
  Function(int) dismissNotification;

  EditNote(
      {Key? key,
      required this.noteEdit,
      required this.createNotification,
      required this.dismissNotification})
      : super(key: key);

  @override
  _EditNoteState createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  final dbNotes = NoteDao.instance;
  TextEditingController customControllerTitle = TextEditingController();
  TextEditingController customControllerText = TextEditingController();

  @override
  void initState() {
    super.initState();
    customControllerTitle.text = widget.noteEdit.title!;
    customControllerText.text = widget.noteEdit.text!;
  }

  void _updateNote() async {
    if (widget.noteEdit.pinned == 1) {
      widget.dismissNotification(widget.noteEdit.id!);
    }
    Map<String, dynamic> row = {
      NoteDao.columnId: widget.noteEdit.id,
      NoteDao.columnTitle: customControllerTitle.text,
      NoteDao.columnText: customControllerText.text,
      NoteDao.columnPinned: 1
    };
    widget.createNotification(
      widget.noteEdit.id!,
      customControllerTitle.text,
      customControllerText.text,
    );
    final update = await dbNotes.update(row);
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
          title: const Text("Edit Note"),
          actions: [
            IconButton(
              icon: const Icon(Icons.save_outlined),
              tooltip: 'Save',
              onPressed: () {
                if (checkProblems().isEmpty) {
                  _updateNote();
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
