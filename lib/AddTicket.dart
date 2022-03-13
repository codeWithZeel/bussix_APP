import 'dart:convert';

import 'package:brtsprojectapp/UrlHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Addticket extends StatefulWidget {
  var stid = "";
  var enid = "";

  Addticket({this.stid, this.enid});

  @override
  _AddticketState createState() => _AddticketState();
}

class _AddticketState extends State<Addticket> {
  var km = "";
  var price = "";

  getticket() async {
    Uri url = Uri.parse(UrlHelper.GET_TICKETDETAIL);
    var response =
        await http.post(url, body: {"stid": widget.stid, "enid": widget.enid});
    if (response.statusCode == 200) // 400 not found 500 Server Error
    {
      print("success");
      var body = response.body.toString();
      var json = jsonDecode(body);
      setState(() {
        km = json["km"];
        price = json["price"];
      });
      print("KM: " + km);
    } else {
      print("API Call Error");
    }
  }

  String selctedstartstation;
  String selectendstation;
  List data = [];

  static const platform = const MethodChannel("razorpay_flutter");

  Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    getticket();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("Database Entry");
    //API

    //API
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Error");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("Waller");
  }

  Future getallstation() async {
    var url = Uri.parse(UrlHelper.GET_BUS_STATION);
    var response = await http.post(url);
    var jsonbody = response.body;
    var jsondata = json.decode(jsonbody);

    setState(() {
      data = jsondata;
    });
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ADD YOUR TICKET"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  elevation: 15.0,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            "images/userlogo.png",
                            height: 75.0,
                          ),
                        ),
                        Text("KM : " + km),
                        Text("Total Payment : " + price),
                        SizedBox(
                          height: 15.0,
                        ),
                        GestureDetector(
                          onTap: () async {},
                          child: InkWell(
                            onTap: () {
                              var options = {
                                'key': 'rzp_test_jJ2kmcVL7StY3N',
                                'amount': 100* 100,
                                'name': 'BRTS',
                                'description': 'TIKCET BOOKING',
                                'retry': {'enabled': true, 'max_count': 1},
                                'send_sms_hash': true,
                                'prefill': {
                                  'contact': '8735824980',
                                  'email': 'test@razorpay.com'
                                },
                                'external': {
                                  'wallets': ['paytm']
                                }
                              };
                              try {
                                _razorpay.open(options);
                              } catch (e) {
                                debugPrint('Error: e');
                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 60.0,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10.0)),
                              alignment: Alignment.center,
                              child: Text("Book & PAY",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      letterSpacing: 3)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
