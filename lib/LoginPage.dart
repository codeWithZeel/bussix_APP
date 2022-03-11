import 'dart:convert';

import 'package:brtsprojectapp/HomeScreen.dart';
import 'package:brtsprojectapp/RegisterPage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'UrlHelper.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _Mobilenumber = TextEditingController();
  TextEditingController __password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
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
                  controller: _Mobilenumber,
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      labelText: "Mobile Number",
                      hintText: "Mobile Number"),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 20.0),
                TextField(
                  controller: __password,
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      labelText: "Password",
                      hintText: "Password"),
                  keyboardType: TextInputType.text,
                  obscureText: true,
                ),
                SizedBox(height: 20.0),
                GestureDetector(
                  onTap: () async {
                    var mobile = _Mobilenumber.text.toString();
                    var password = __password.text.toString();
                    Uri url = Uri.parse(UrlHelper.Login);
                    var response = await http.post(url,
                        body: {"contact": mobile, "password": password});
                    if (response.statusCode == 200) {
                      var json = jsonDecode(response.body.toString());
                      if (json["status"] == "yes") {
                        var user_id = json["userdata"]["user_id"].toString();
                        var name = json["userdata"]["Name"].toString();
                        var email = json["userdata"]["Email"].toString();

                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString("islogin", "yes");
                        prefs.setString("userid", user_id);
                        prefs.setString("name", name);
                        prefs.setString("email", email);

                        Fluttertoast.showToast(
                            msg: "Login Successful",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HomeScreen()));
                      } else {
                        Fluttertoast.showToast(
                            msg: "Mobile number or password not match",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60.0,
                    color: Colors.blue,
                    alignment: Alignment.center,
                    child: Text("Login",
                        style: TextStyle(color: Colors.white, fontSize: 25.0)),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed("ForgotPassword");
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "Forgot Password ?",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an Account ? "),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop(context);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => RegisterPage()));
                      },
                      child: Text(
                        "REGISTER",
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
    );
  }
}
