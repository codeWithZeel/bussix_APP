import 'dart:convert';

import 'package:brtsprojectapp/LoginPage.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'UrlHelper.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _name = TextEditingController();
  TextEditingController _contact = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Image.asset("images/userlogo.png",width: 250,)),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    controller: _name,
                    decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        labelText: "Name",
                        hintText: "Enter Name"),
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 20.0),
                  TextField(
                    controller: _contact,
                    decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        labelText: "Mobile Number",
                        hintText: "Enter Mobile Number"),
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 20.0),
                  TextField(
                    controller: _email,
                    decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        labelText: "Email",
                        hintText: "Enter Email"),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 20.0),
                  TextField(
                    controller: _password,
                    decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        labelText: "Password",
                        hintText: "Enter Password"),
                    keyboardType: TextInputType.text,
                    obscureText: true,
                  ),
                  SizedBox(height: 20.0),
                  GestureDetector(
                    onTap: () async {
                      var name = _name.text.toString();
                      var contact = _contact.text.toString();
                      var email = _email.text.toString();
                      var password = _password.text.toString();

                      Uri url = Uri.parse(UrlHelper.REGISTER);
                      var response = await http.post(url, body: {
                        "name": name,
                        "contact": contact,
                        "email": email,
                        "password": password
                      });
                      if (response.statusCode == 200) {
                        var json = jsonDecode(response.body.toString());
                        if (json["status"] == "yes") {
                          CoolAlert.show(
                              context: context,
                              type: CoolAlertType.success,
                              text: 'Register successfully!',
                              onConfirmBtnTap: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                              });

                          print("Record Inserted");
                        } else {
                          CoolAlert.show(
                            context: context,
                            type: CoolAlertType.error,
                            title: 'Oops...',
                            text: 'Sorry, something went wrong',
                            loopAnimation: false,
                          );
                        }
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60.0,
                      color: Colors.blue,
                      alignment: Alignment.center,
                      child: Text("Register",
                          style:
                              TextStyle(color: Colors.white, fontSize: 25.0)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an Account ? "),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop(context);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginPage()));
                        },
                        child: Text(
                          "LOGIN",
                          style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
