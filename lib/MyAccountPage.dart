import 'dart:convert';

import 'package:brtsprojectapp/UrlHelper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class MyAccountPage extends StatefulWidget {


  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MyAccountPage"),
      ),
      body: Text("MyAccountPage"),
    );
  }
}
