import '../classes/note.dart';

class AppState {
  List<Note> notes = [];

  AppState({required this.notes});

  static AppState initialState() => AppState(
        notes: [],
      );

  AppState copyWith({
    List<Note>? notes,
  }) {
    return AppState(
      notes: notes ?? this.notes,
    );
  }
}
