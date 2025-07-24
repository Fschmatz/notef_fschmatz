import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notef_fschmatz/service/note_service.dart';

import '../classes/note.dart';

class DialogStoreNote extends StatefulWidget {
  @override
  State<DialogStoreNote> createState() => _DialogStoreNoteState();

  final Note? note;

  const DialogStoreNote({Key? key, this.note}) : super(key: key);
}

class _DialogStoreNoteState extends State<DialogStoreNote> {
  final NoteService noteService = NoteService();
  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerText = TextEditingController();
  bool _validTitle = true;
  bool _isUpdate = false;

  @override
  void initState() {
    super.initState();

    _isUpdate = widget.note != null;

    if (_isUpdate) {
      _controllerTitle.text = widget.note!.title!;
      _controllerText.text = widget.note!.text!;
    }
  }

  void _store() {
    if (validateTextFields()) {
      if (_isUpdate) {
        _update();
      } else {
        _insert();
      }

      Navigator.of(context).pop();
    } else {
      setState(() {
        _validTitle;
      });
    }
  }

  void _insert() async {
    noteService.insert(_controllerTitle.text, _controllerText.text);
  }

  void _update() async {
    noteService.update(widget.note!, _controllerTitle.text, _controllerText.text);
  }

  bool validateTextFields() {
    if (_controllerTitle.text.isEmpty) {
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
                  controller: _controllerTitle,
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
                    controller: _controllerText,
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
              _store();
            },
            child: const Text('Save'))
      ],
    );
  }
}
