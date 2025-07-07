import 'package:hive_flutter/hive_flutter.dart';
import '../models/note.dart';

class HiveService {
  static const String _noteBox = 'notes';

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(NoteAdapter());
    await Hive.openBox<Note>(_noteBox);
  }

  Box<Note> _getNoteBox() {
    return Hive.box<Note>(_noteBox);
  }

  Future<void> addNote(Note note) async {
    await _getNoteBox().add(note);
  }

  Future<void> updateNote(Note note) async {
    await note.save();
  }

  Future<void> deleteNote(Note note) async {
    await note.delete();
  }

  List<Note> getNotes() {
    return _getNoteBox().values.toList();
  }

  Note? getNote(int index) {
    return _getNoteBox().getAt(index);
  }
}


