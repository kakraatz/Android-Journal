import 'package:flutter/material.dart';
import '../widgets/journal_entry_form.dart';

class NewEntry extends StatelessWidget {
  static const route = '/new_entry';
  @override
  Widget build(BuildContext context) {
    return JournalEntryForm();
  }
}
