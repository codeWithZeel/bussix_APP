import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'UrlHelper.dart';

class AddComplain extends StatefulWidget {
  @override
  _AddComplainState createState() => _AddComplainState();
}

class _AddComplainState extends State<AddComplain> {
  TextEditingController _Userid = TextEditingController();
  TextEditingController _Complain = TextEditingController();
  TextEditingController _Image = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AddComplain"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Userid"),
              TextField(
                controller: _Userid,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 15.0),
              Text("Complain"),
              TextField(
                controller: _Complain,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 15.0),
              Text("Image"),
              TextField(
                controller: _Image,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 15.0),
              GestureDetector(
                onTap: () async {
                  var Userid = _Userid.text.toString();
                  var Complain = _Complain.text.toString();
                  var Image = _Image.text.toString();

                  Uri url = Uri.parse(UrlHelper.AddComplain);
                  var response = await http.post(url,body: {
                    "Userid": Userid,
                    "Complain": Complain,
                    "Image": Image
                  });
                  if (response.statusCode == 200) {
                    var json = jsonDecode(response.body.toString());
                    if (json["status"] == "yes") {
                      print("complain submitted");
                    } else {
                      print("Not submitted");
                    }
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60.0,
                  color: Colors.blue,
                  alignment: Alignment.center,
                  child: Text("Complain",style: TextStyle(color: Colors.white, fontSize: 25.0)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
