import 'dart:convert';

import 'package:brtsprojectapp/UrlHelper.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController _password = new TextEditingController();
  TextEditingController _confirmpassword = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password"),
      ),
      body: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _password,
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      labelText: "New Password",
                      hintText: "Enter New Password"),
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Please Enter Password";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _confirmpassword,
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      labelText: "Confirm Password",
                      hintText: "Re-Enter Password"),
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Please Re-Enter Password";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    var url = Uri.parse(UrlHelper.CHANGE_PASSWORD);
                    var response = await http.post(url, body: {
                      "userid": prefs.getString("userid"),
                      "password": _confirmpassword.text.toString()
                    });
                    if (response.statusCode == 200) {
                      CoolAlert.show(
                          context: context,
                          type: CoolAlertType.success,
                          text:
                              "Successfully Password Changed, Now Login To Continue !",
                          onConfirmBtnTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            Navigator.of(context).pushNamed("Login");
                          });
                    } else {
                      print("API Error");
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60.0,
                    color: Colors.blue,
                    alignment: Alignment.center,
                    child: Text("Change Password",
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
