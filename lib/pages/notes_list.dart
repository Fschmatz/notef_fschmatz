import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:notef_fschmatz/classes/note.dart';
import 'package:notef_fschmatz/db/note_dao.dart';
import 'package:notef_fschmatz/pages/new_note.dart';
import 'package:notef_fschmatz/widgets/note_card.dart';

class NotesList extends StatefulWidget {
  @override
  _NotesListState createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  List<Map<String, dynamic>> notesList = [];
  final Notes = NoteDao.instance;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getAll();
  }

  Future<void> getAll() async {
    var resp = await Notes.queryAllRowsDesc();
    notesList = resp;

    setState(() {
      loading = false;
    });
  }

  void createNotification(int id, String textTitle, String textBody) async {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: id,
          channelKey: 'basic_channel',
          title: textTitle,
          notificationLayout: NotificationLayout.BigText,
          locked: true,
          autoDismissible: false,
          body: textBody),
    );
  }

  dismissNotification(int id) async {
    AwesomeNotifications().dismiss(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 600),
        child: loading
            ? const Center(child: SizedBox.shrink())
            : notesList.isEmpty
                ? const Center(
                    child: Text(
                    'It\'s a little empty in here',
                    style: TextStyle(fontSize: 18),
                  ))
                : ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                        ListView.builder(
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: notesList.length,
                          itemBuilder: (context, index) {
                            return NoteCard(
                              note: Note(
                                notesList[index]['id'],
                                notesList[index]['title'],
                                notesList[index]['text'],
                                notesList[index]['pinned'] ?? 0,
                              ),
                              refreshHome: getAll,
                              createNotification: createNotification,
                              dismissNotification: dismissNotification,
                            );
                          },
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                      ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => NewNote(
                  createNotification: createNotification,
                ),
              )).then((value) => getAll());
        },
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}
