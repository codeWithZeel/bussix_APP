import 'package:flutter/material.dart';

class LogoutPage extends StatefulWidget {

  @override
  _LogoutPageState createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LogoutPage"),
      ),
      body: Text("LogoutPage"),
    );
  }
}
