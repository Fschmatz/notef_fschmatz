import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:notef_fschmatz/service/store_service.dart';

import '../classes/note.dart';
import '../db/note_dao.dart';

class NoteService extends StoreService {
  final dbNote = NoteDao.instance;

  Future<List<Note>> findAll() async {
    var resp = await dbNote.queryAllRowsDesc();

    return resp.isNotEmpty ? resp.map((map) => Note.fromMap(map)).toList() : [];
  }

  Future<void> insert(String title, String text) async {
    Map<String, dynamic> row = {NoteDao.columnTitle: title, NoteDao.columnText: text, NoteDao.columnPinned: 1};
    final id = await dbNote.insert(row);

    createNotification(
      id,
      title,
      text,
    );

    await loadNotes();
  }

  Future<void> delete(Note note) async {
    if (note.isPinned()) {
      dismissNotification(note.id!);
    }

    await dbNote.delete(note.id!);
    await loadNotes();
  }

  Future<void> changeState(Note note) async {
    Map<String, dynamic> row = {
      NoteDao.columnId: note.id,
      NoteDao.columnPinned: note.pinned == 0 ? 1 : 0,
    };

    await dbNote.update(row);
    await loadNotes();
  }

  Future<void> update(Note note, String title, String text) async {
    if (note.isPinned()) {
      dismissNotification(note.id!);
    }

    Map<String, dynamic> row = {NoteDao.columnId: note.id, NoteDao.columnTitle: title, NoteDao.columnText: text, NoteDao.columnPinned: 1};

    createNotification(
      note.id!,
      title,
      text,
    );

    await dbNote.update(row);
    await loadNotes();
  }

  Future<void> createNotification(int id, String textTitle, String textBody) async {
    await AwesomeNotifications().createNotification(
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

  Future<void> dismissNotification(int id) async {
    await AwesomeNotifications().dismiss(id);
  }
}
