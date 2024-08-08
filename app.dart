import 'package:flutter/material.dart';
import 'screens/journal_entry_list.dart';
import 'screens/journal_entry.dart';
import 'screens/new_entry.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatefulWidget {
  final SharedPreferences preferences;
  App({Key? key, required this.preferences}) : super(key: key);
  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  static const MODE_KEY = 'theme';
  bool get themeMode => widget.preferences.getBool(MODE_KEY) ?? true;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Journal',
        routes: {
          '/': (context) =>
              JournalEntryListScreen(mode: setMode, theme: themeMode),
          '/existing_entry': (context) => ExistingEntry(),
          '/new_entry': (context) => NewEntry()
        },
        theme: ThemeData(primarySwatch: Colors.orange, brightness: getMode()));
  }

  Brightness getMode() {
    if (themeMode == false) {
      return Brightness.light;
    } else {
      return Brightness.dark;
    }
  }

  void setMode(theme) {
    setState(() {
      widget.preferences.setBool(MODE_KEY, theme);
    });
  }
}
