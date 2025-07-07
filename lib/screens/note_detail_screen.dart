import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:anime_notes_pro/models/note.dart';
import 'package:anime_notes_pro/screens/note_list_screen.dart';

class NoteDetailScreen extends ConsumerStatefulWidget {
  final Note? note;

  const NoteDetailScreen({super.key, this.note});

  @override
  ConsumerState<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends ConsumerState<NoteDetailScreen> {
  final _titleController = TextEditingController();
  final QuillController _quillController = QuillController.basic();
  String _selectedMoodIcon = 'assets/icons/emilia_chibi.png'; // Default mood icon
  List<String> _tags = [];

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _quillController.document = Document.fromJson(widget.note!.content as List);
      _selectedMoodIcon = widget.note!.moodIcon;
      _tags = widget.note!.tags;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _quillController.dispose();
    super.dispose();
  }

  void _saveNote() {
    final title = _titleController.text;
    final content = _quillController.document.toDelta().toJson();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Judul tidak boleh kosong')),
      );
      return;
    }

    final now = DateTime.now();
    if (widget.note == null) {
      // Add new note
      final newNote = Note(
        title: title,
        content: content.toString(), // Convert Delta to String for now
        tags: _tags,
        moodIcon: _selectedMoodIcon,
        createdAt: now,
        updatedAt: now,
      );
      ref.read(notesProvider.notifier).addNote(newNote);
    } else {
      // Update existing note
      final updatedNote = Note(
        title: title,
        content: content.toString(), // Convert Delta to String for now
        tags: _tags,
        moodIcon: _selectedMoodIcon,
        createdAt: widget.note!.createdAt,
        updatedAt: now,
      );
      ref.read(notesProvider.notifier).updateNote(updatedNote);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'Tambah Catatan Baru' : 'Edit Catatan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveNote,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Judul',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    QuillToolbar.basic(controller: _quillController),
                    Expanded(
                      child: QuillEditor.basic(
                        controller: _quillController,
                        readOnly: false,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            // Mood Icon Selector
            Row(
              children: [
                const Text('Mood Icon:'),
                const SizedBox(width: 8.0),
                DropdownButton<String>(
                  value: _selectedMoodIcon,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedMoodIcon = newValue!;
                    });
                  },
                  items: <String>[
                    'assets/icons/emilia_chibi.png',
                    'assets/icons/rem_chibi.png',
                    'assets/icons/ram_chibi.png',
                    'assets/icons/beatrice_chibi.png',
                    'assets/icons/rem_mood_happy.png',
                    'assets/icons/emilia_mood_sad.png',
                    'assets/icons/ram_mood_mischievous.png',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Image.asset(value, width: 24, height: 24),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            // Tags Input (simple for now)
            TextField(
              decoration: const InputDecoration(
                labelText: 'Tags (pisahkan dengan koma)',
                border: OutlineInputBorder(),
              ),
              onChanged: (text) {
                _tags = text.split(',').map((e) => e.trim()).toList();
              },
            ),
          ],
        ),
      ),
    );
  }
}


