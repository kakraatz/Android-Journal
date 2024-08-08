import 'package:flutter/material.dart';

class JournalScaffold extends StatefulWidget {
  String title;
  final body;
  final entry_button;
  final mode;
  final theme;

  JournalScaffold(
      {Key? key,
      required this.title,
      this.body,
      this.entry_button,
      this.mode,
      this.theme})
      : super(key: key);

  @override
  JournalScaffoldState createState() => JournalScaffoldState();
}

class JournalScaffoldState extends State<JournalScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: const Icon(Icons.book),
          title: Text(widget.title),
          actions: [
            Builder(
                builder: (context) => IconButton(
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                    icon: const Icon(Icons.settings_brightness)))
          ]),
      body: Container(
          child: widget.body,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width),
      floatingActionButton: widget.entry_button,
      endDrawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.orange,
              ),
              child: Text('Settings')),
          SwitchListTile(
              title: const Text('Dark Mode'),
              value: widget.theme,
              onChanged: (value) {
                widget.mode(value);
                //AppState().setMode(widget.mode);
                //Navigator.pop(context);
              })
        ],
      )),
    );
  }
}
