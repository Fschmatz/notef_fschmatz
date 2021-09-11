import 'dart:async';
import 'package:flutter/material.dart';
import 'package:notef_fschmatz/classes/note.dart';
import 'package:notef_fschmatz/db/note_dao.dart';
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
  }

  Future<void> getAll() async {
    var resp = await Notes.queryAllRows();
    setState(() {
      dayNotesList = resp;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 600),
        child: loading
            ? const Center(child: SizedBox.shrink())
            : ListView(physics: const AlwaysScrollableScrollPhysics(), children: [
                ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(height: 12,),
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return NoteCard(
                      note: Note(
                        0,
                        'aqui está a nota',
                       0,
                      /*  dayNotesList[index]['id'],
                        dayNotesList[index]['note'],
                        dayNotesList[index]['starred'] == null
                            ? 0
                            : dayNotesList[index]['starred'],*/
                      ),
                      refreshHome: getAll,
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
         /* Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => NewNote(),
                fullscreenDialog: true,
              )).then((value) => getRecents());*/
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
