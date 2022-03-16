import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'UrlHelper.dart';

class AddComplain extends StatefulWidget {
  @override
  _AddComplainState createState() => _AddComplainState();
}

class _AddComplainState extends State<AddComplain> {
  File _image;
  final picker = ImagePicker();
  TextEditingController _Userid = TextEditingController();
  TextEditingController _Complain = TextEditingController();
  TextEditingController _Image = TextEditingController();

  Future _getImagefromgallery() async {
    final pickedImage = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      } else {
        print("No Image Selected");
      }
    });
  }

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
              TextField(
                controller: _Userid,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    labelText: "Username",
                    hintText: "Username"),
              ),
              SizedBox(height: 15.0),
              TextField(
                controller: _Complain,
                keyboardType: TextInputType.text,
                maxLines: 8,
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    labelText: "Complain Text",
                    hintText: "Complain Text"),
              ),
              SizedBox(height: 15.0),
              GestureDetector(
                onTap: () async {
                  var Userid = _Userid.text.toString();
                  var Complain = _Complain.text.toString();
                  var Image = _Image.text.toString();

                  Uri url = Uri.parse(UrlHelper.AddComplain);
                  var response = await http.post(url, body: {
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
                  child: Text("Complain",
                      style: TextStyle(color: Colors.white, fontSize: 25.0)),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera),
        tooltip: "Add Image",
        onPressed: (){
          _getImagefromgallery();
        },
      ),
    );
  }
}
