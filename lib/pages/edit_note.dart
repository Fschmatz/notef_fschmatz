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
    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit Note"),
         /* actions: [
            IconButton(
              icon: const Icon(Icons.save_outlined),
              tooltip: 'Save',
              onPressed: () {
                if (validateTextFields()) {
                  _updateNote();
                  Navigator.of(context).pop();
                } else {
                  setState(() {
                    _validTitle;
                  });
                }
              },
            ),
          ],*/
        ),
        body: ListView(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: TextField(
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
        ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (validateTextFields()) {
            _updateNote();
            Navigator.of(context).pop();
          } else {
            setState(() {
              _validTitle;
            });
          }
        },
        child: Icon(
          Icons.save_outlined,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}
