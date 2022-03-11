import 'dart:convert';

import 'package:brtsprojectapp/UrlHelper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class Addticket extends StatefulWidget {


  @override
  _AddticketState createState() => _AddticketState();
}

class _AddticketState extends State<Addticket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ADD YOUR TICKET"),
      ),
      body: Text("add ticket"),
    );
  }
}
