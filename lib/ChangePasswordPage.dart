import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {


  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ChangePasswordPage"),
      ),
      body: Text(" This is ChangePasswordPage"),
    );
  }
}