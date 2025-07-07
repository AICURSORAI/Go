import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:anime_notes_pro/services/hive_service.dart';
import 'package:anime_notes_pro/screens/note_list_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService().init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.purple,
        // Tambahkan warna dan gradien pastel lembut ala mansion Roswaal
        // Aksen biru es Emilia
      ),
      dark: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepPurple,
        // Tambahkan tema gelap jika diperlukan
      ),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        title: 'Anime Notes Pro',
        theme: theme,
        darkTheme: darkTheme,
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    NoteListScreen(), // Emilia Notes
    NoteListScreen(), // Rem Notes
    NoteListScreen(), // Ram Notes
    NoteListScreen(), // Beatrice Library
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anime Notes Pro - Re:Zero Edition'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icons/emilia_chibi.png')),
            label: 'Emilia',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icons/rem_chibi.png')),
            label: 'Rem',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icons/ram_chibi.png')),
            label: 'Ram',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icons/beatrice_chibi.png')),
            label: 'Beatrice',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}


