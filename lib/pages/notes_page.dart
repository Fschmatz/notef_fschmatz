import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:notef_fschmatz/classes/note.dart';
import 'package:notef_fschmatz/db/note_dao.dart';
import 'package:notef_fschmatz/pages/new_note.dart';
import 'package:notef_fschmatz/widgets/note_card.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List<Map<String, dynamic>> dayNotesList = [];
  final Notes = NoteDao.instance;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getAll();
   // _receiveActionDone();
  }

  Future<void> getAll() async {
    var resp = await Notes.queryAllOrderPinnedState();
    setState(() {
      dayNotesList = resp;
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
          autoCancel: false,//não fecha a not ao abrir por ela
          body: textBody),
    /*  actionButtons: [
        NotificationActionButton(
          key: 'MARK_DONE',
          label: 'Done',
        )
      ],*/
    );
  }

  dismissNotification(int id) async {
    AwesomeNotifications().dismiss(id);
  }

  void _receiveActionDone() async {
    (receivedNotification) {
      Navigator.of(context)
          .pushNamed(dismissNotification(receivedNotification.id));
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 600),
        child: loading
            ? const Center(child: SizedBox.shrink())
            : ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                    ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 12,
                      ),
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: dayNotesList.length,
                      itemBuilder: (context, index) {
                        return NoteCard(
                          note: Note(
                            dayNotesList[index]['id'],
                            dayNotesList[index]['title'],
                            dayNotesList[index]['text'],
                            dayNotesList[index]['pinned'] ?? 0,
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
              MaterialPageRoute<void>(
                builder: (BuildContext context) => NewNote(),
                fullscreenDialog: true,
              )).then((value) => getAll());
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
