import 'package:flutter/material.dart';

class ExistingEntry extends StatelessWidget {
  static const route = '/existing_entry';

  @override
  Widget build(BuildContext context) {
    final receivedData = ModalRoute.of(context)?.settings.arguments as Map;
    final date = receivedData['date'];
    final title = receivedData['title'];
    final body = receivedData['body'];
    final rating = receivedData['rating'];

    return Scaffold(
        appBar: AppBar(
          leading: Text(date, style: TextStyle(fontSize: 11)),
          title: Text(title),
        ),
        body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.only(top: 100),
              child: Column(children: [
                Text(body),
                SizedBox(height: 100),
                Text('Rating: ' + rating.toString()),
                ElevatedButton(
                    child: const Text('Back'),
                    onPressed: () async {
                      Navigator.pop(context);
                    })
              ]),
            )));
  }
}
