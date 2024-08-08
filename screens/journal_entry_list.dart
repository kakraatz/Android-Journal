import 'package:flutter/material.dart';
import '../db/database_manager.dart';
import '../widgets/welcome.dart';
import '../widgets/journal_scaffold.dart';
import '../models/journal.dart';
import '../models/journal_entry.dart';

class JournalEntryListScreen extends StatefulWidget {
  static const route = '/';
  final mode;
  final theme;

  JournalEntryListScreen({Key? key, this.mode, this.theme}) : super(key: key);
  @override
  JournalEntryListScreenState createState() => JournalEntryListScreenState();
}

class JournalEntryListScreenState extends State<JournalEntryListScreen> {
  Journal? journal;

  @override
  void initState() {
    super.initState();
    loadJournal();
  }

  void loadJournal() async {
    final databaseManager = DatabaseManager.getInstance();
    List<JournalEntry> journalRecords = await databaseManager.journalEntries();
    if (journalRecords.isNotEmpty) {
      setState(() {
        journal = Journal(entries: journalRecords);
      });
    }
  }

  Widget switchHomeScreen() {
    if (journal != null) {
      return ListView.builder(
          itemCount: journal!.entries.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(Icons.menu_book),
              title: Text('${journal!.entries[index].title}'),
              subtitle: Text('${journal!.entries[index].date}'),
              onTap: () {
                Navigator.of(context).pushNamed('/existing_entry', arguments: {
                  'date': journal!.entries[index].date,
                  'title': journal!.entries[index].title,
                  'body': journal!.entries[index].body,
                  'rating': journal!.entries[index].rating
                });
              },
            );
          });
    } else {
      return Welcome();
    }
  }

/*
  Widget horizontalEntry() {

  }

  Widget verticalEntry() {
    
  }
*/
  @override
  Widget build(BuildContext context) {
    String title;

    if (journal != null) {
      title = 'Journal Entries';
    } else {
      title = 'Welcome';
    }

    return JournalScaffold(
        mode: widget.mode,
        theme: widget.theme,
        title: title,
        entry_button: FloatingActionButton(
            backgroundColor: Colors.orange,
            onPressed: () {
              Navigator.of(context).pushNamed('/new_entry');
            },
            child: const Icon(Icons.add)),
        body: LayoutBuilder(builder: (context, constraints) {
          return switchHomeScreen();
        }));
  }
}
