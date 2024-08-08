import 'package:flutter/material.dart';
import '../db/database_manager.dart';
import '../db/journal_entry_dto.dart';
import '../models/journal_entry.dart';

class JournalEntryForm extends StatefulWidget {
  final dto = JournalEntry();
  final journalEntryValues = JournalEntryDTO();
  @override
  JournalEntryFormState createState() => JournalEntryFormState();
}

class JournalEntryFormState extends State<JournalEntryForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
                key: formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      titleTextField(),
                      bodyTextField(),
                      ratingDropdown(),
                      buttons(context)
                    ]))));
  }

  Widget titleTextField() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: TextFormField(
            autofocus: true,
            decoration: const InputDecoration(
                labelText: 'Title', border: OutlineInputBorder()),
            onSaved: (value) {
              widget.journalEntryValues.title = value;
            },
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'Please enter a title';
              } else {
                return null;
              }
            }));
  }

  Widget bodyTextField() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: TextFormField(
            autofocus: true,
            decoration: const InputDecoration(
                labelText: 'Body', border: OutlineInputBorder()),
            onSaved: (value) {
              widget.journalEntryValues.body = value;
            },
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'Please enter a body';
              } else {
                return null;
              }
            }));
  }

  Widget ratingDropdown() {
    int? valueFromList;
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: DropdownButtonFormField(
            value: valueFromList,
            icon: const Icon(Icons.star),
            decoration: const InputDecoration(
                labelText: 'Rating', border: OutlineInputBorder()),
            onChanged: (int? newValue) {
              setState(() {
                valueFromList = newValue;
              });
            },
            items: <int>[1, 2, 3, 4].map<DropdownMenuItem<int>>((int value) {
              return DropdownMenuItem<int>(value: value, child: Text('$value'));
            }).toList(),
            onSaved: (value) {
              widget.journalEntryValues.rating = value;
            },
            validator: (int? value) {
              if (value == null) {
                return 'Please select a rating';
              } else {
                return null;
              }
            }));
  }

  Widget buttons(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [cancelButton(context), saveButton(context)]);
  }

  Widget cancelButton(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: ElevatedButton(
            child: const Text('Cancel'),
            onPressed: () async {
              Navigator.pop(context);
            }));
  }

  Widget saveButton(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: ElevatedButton(
            child: const Text('Save'),
            onPressed: () {
              final form = formKey.currentState;
              if (form != null && form.validate()) {
                form.save();
                addDateToJournalEntryValues();
                final databaseManager = DatabaseManager.getInstance();
                databaseManager.saveJournalEntry(
                    dto: widget.journalEntryValues);
                Navigator.of(context).pushNamed('/');
              }
            }));
  }

  void addDateToJournalEntryValues() {
    widget.journalEntryValues.dateTime = DateTime.now();
  }
}
