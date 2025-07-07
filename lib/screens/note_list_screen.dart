import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anime_notes_pro/models/note.dart';
import 'package:anime_notes_pro/services/hive_service.dart';
import 'package:anime_notes_pro/screens/note_detail_screen.dart';

final hiveServiceProvider = Provider((ref) => HiveService());

final notesProvider = StateNotifierProvider<NotesNotifier, List<Note>>((ref) {
  final hiveService = ref.watch(hiveServiceProvider);
  return NotesNotifier(hiveService);
});

class NotesNotifier extends StateNotifier<List<Note>> {
  final HiveService _hiveService;

  NotesNotifier(this._hiveService) : super(_hiveService.getNotes());

  void addNote(Note note) {
    _hiveService.addNote(note);
    state = _hiveService.getNotes();
  }

  void updateNote(Note note) {
    _hiveService.updateNote(note);
    state = _hiveService.getNotes();
  }

  void deleteNote(Note note) {
    _hiveService.deleteNote(note);
    state = _hiveService.getNotes();
  }
}

class NoteListScreen extends ConsumerWidget {
  const NoteListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(notesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catatan Anda'),
      ),
      body: notes.isEmpty
          ? const Center(child: Text('Tidak ada catatan. Tambahkan yang baru!'))
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(note.title),
                    subtitle: Text(note.content),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => NoteDetailScreen(note: note),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            ref.read(notesProvider.notifier).deleteNote(note);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const NoteDetailScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}


