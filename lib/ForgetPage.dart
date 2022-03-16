import 'dart:convert';
import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'UrlHelper.dart';

class ForgetPage extends StatefulWidget {


  @override
  _ForgetPageState createState() => _ForgetPageState();
}

class _ForgetPageState extends State<ForgetPage> {
  TextEditingController _contact = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forget password"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _contact,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      labelText: "Mobile Number",
                      hintText: "Mobile Number"),
                ),

                SizedBox(height: 15.0),
                GestureDetector(
                  onTap: () async {
                    var contact = _contact.text.toString();

                    Uri url = Uri.parse(UrlHelper.FORGOT_PASSWORD);
                    var response = await http.post(url, body: {
                      "contact": contact,

                    });
                    if (response.statusCode == 200) {
                      var json = jsonDecode(response.body.toString());
                      if (json["status"] == "yes") {
                        var id = json["userid"];
                        var otp = json["otp"];
                        var fetchmail = json["email"];
                        CoolAlert.show(
                            context: context,
                            type: CoolAlertType.success,
                            text: "Mail Successfully send on " + fetchmail,
                            onConfirmBtnTap: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pushNamed(
                                  "OTPChecking",
                                  arguments: {"userid": id, "otp": otp});
                            });
                        print("successfully mail sent "+ otp);
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
                    child: Text("Send OTP",
                        style: TextStyle(color: Colors.white, fontSize: 25.0)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),

    );
  }
}
