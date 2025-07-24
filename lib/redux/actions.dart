import '../classes/note.dart';
import '../service/note_service.dart';
import 'app_action.dart';
import 'app_state.dart';

class LoadNotesAction extends AppAction {
  @override
  Future<AppState> reduce() async {
    List<Note> notes = await NoteService().findAll();

    return state.copyWith(notes: notes);
  }
}
