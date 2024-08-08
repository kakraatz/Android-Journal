import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  @override
  WelcomeState createState() => WelcomeState();
}

class WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
          Text('Journal',
              style: TextStyle(
                  fontSize: 22, decoration: TextDecoration.underline)),
          Padding(
              padding: EdgeInsets.all(0),
              child: Icon(Icons.menu_book, size: 150))
        ])));
  }
}
