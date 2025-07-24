import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:notef_fschmatz/pages/notes_list.dart';
import 'package:notef_fschmatz/widgets/dialog_store_note.dart';

import 'configs/settings_page.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();

  const Home({super.key});
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();

    AwesomeNotifications().isNotificationAllowed().then((isAllowed) => {
          if (!isAllowed) {AwesomeNotifications().requestPermissionToSendNotifications()}
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Notef'),
          actions: [
            IconButton(
                icon: const Icon(
                  Icons.settings_outlined,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const SettingsPage(),
                      ));
                }),
          ],
        ),
        body: const NotesList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => showDialog(
              context: context,
              builder: (BuildContext context) {
                return const DialogStoreNote();
              }),
          child: const Icon(
            Icons.add,
          ),
        ));
  }
}
