/*
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class EditNote extends StatefulWidget {
  DayNote dayNoteEdit;

  EditNote({Key? key, required this.dayNoteEdit}) : super(key: key);

  @override
  _EditNoteState createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  final dbDayNotes = NoteDao.instance;
  late DateTime dateSelected;

  TextEditingController customControllerNote = TextEditingController();

  @override
  void initState() {
    super.initState();
    customControllerNote.text = widget.dayNoteEdit.note;
    dateSelected = DateFormat('dd/MM').parse(widget.dayNoteEdit.day);
  }

  getSelectedDateFormatted() {
    return DateFormat('dd/MM').format(dateSelected);
  }

  void _updateDayNote() async {
    Map<String, dynamic> row = {
      DayNoteDao.columnId: widget.dayNoteEdit.id,
      DayNoteDao.columnDay: getSelectedDateFormatted().toString(),
      DayNoteDao.columnNote: customControllerNote.text,
    };
    final update = await dbDayNotes.update(row);
  }

  String checkProblems() {
    String errors = "";
    if (customControllerNote.text.isEmpty) {
      errors += "Note is empty\n";
    }
    return errors;
  }

  showAlertDialogErrors(BuildContext context) {
    Widget okButton = TextButton(
      child: Text(
        "Ok",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      elevation: 3.0,
      title: Text(
        "Error",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      content: Text(
        checkProblems(),
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

  chooseDate() async {
    DateTime? data = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5));

    if (data != null) {
      setState(() {
        dateSelected = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Note"),
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
              child: IconButton(
                icon: Icon(Icons.save_outlined),
                tooltip: 'Save',
                onPressed: () {
                  if (checkProblems().isEmpty) {
                    _updateDayNote();
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
            leading: SizedBox(
              height: 0.1,
            ),
            title: Text("Choose Date".toUpperCase(),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).accentTextTheme.headline1!.color)),
          ),
          ListTile(
            onTap: () {
              chooseDate();
            },
            leading: Icon(Icons.calendar_today_outlined),
            title: Text(getSelectedDateFormatted().toString()),
          ),
          ListTile(
            leading: SizedBox(
              height: 0.1,
            ),
            title: Text("Note".toUpperCase(),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).accentTextTheme.headline1!.color)),
          ),
          ListTile(
            leading: Icon(Icons.notes_outlined),
            title: TextField(
              autofocus: true,
              minLines: 1,
              maxLines: 12,
              maxLength: 2000,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              controller: customControllerNote,
              decoration: InputDecoration(
                focusColor: Theme.of(context).accentColor,
                helperText: "* Required",
              ),
              style: TextStyle(
                fontSize: 17,
              ),
            ),
          ),
        ]));
  }
}
*/
