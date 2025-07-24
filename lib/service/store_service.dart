import '../main.dart';
import '../redux/actions.dart';

abstract class StoreService {
  Future<void> loadNotes() async {
    await store.dispatch(LoadNotesAction());
  }
}
