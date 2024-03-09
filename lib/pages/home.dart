import 'package:flutter/material.dart';
import 'package:notef_fschmatz/pages/notes_list.dart';
import 'configs/settings_page.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
        body: NotesList(),
    );
  }
}
