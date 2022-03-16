import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

class OTPChecking extends StatefulWidget {
  @override
  _OTPCheckingState createState() => _OTPCheckingState();
}

class _OTPCheckingState extends State<OTPChecking> {
  TextEditingController _otp = TextEditingController();
  String otp = "", id = "";

  @override
  Widget build(BuildContext context) {
    final Map arg = ModalRoute.of(context).settings.arguments as Map;
    if (arg != null) {
      setState(() {
        id = arg["userid"];
        otp = arg["otp"];
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP Verification"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              TextField(
                controller: _otp,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    labelText: "OTP",
                    hintText: "OTP"),
              ),
              SizedBox(height: 15.0),
              GestureDetector(
                onTap: () async {
                  if (otp == _otp.text.toString()) {
                    CoolAlert.show(
                        context: context,
                        type: CoolAlertType.success,
                        text: "Now you can change your password !",
                        confirmBtnText: "Change Password",
                        onConfirmBtnTap: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pushNamed("ChangePassword",
                              arguments: {"userid": id});
                        });
                  }else{
                    CoolAlert.show(
                      context: context,
                      type: CoolAlertType.warning,
                      text: "The OTP entered is incorrect.",
                    );
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60.0,
                  color: Colors.blue,
                  alignment: Alignment.center,
                  child: Text("Verify OTP",
                      style: TextStyle(color: Colors.white, fontSize: 25.0)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
