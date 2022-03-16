import 'package:brtsprojectapp/AddComplain.dart';
import 'package:brtsprojectapp/AddTicket.dart';
import 'package:brtsprojectapp/AddTicket2.dart';
import 'package:brtsprojectapp/AllBusPage.dart';
import 'package:brtsprojectapp/BookYourPassPage.dart';
import 'package:brtsprojectapp/BusRoutePage.dart';
import 'package:brtsprojectapp/ChangePasswordPage.dart';
import 'package:brtsprojectapp/ComplainPage.dart';
import 'package:brtsprojectapp/ForgetPage.dart';
import 'package:brtsprojectapp/LetestNewsPage.dart';
import 'package:brtsprojectapp/LoginPage.dart';
import 'package:brtsprojectapp/HomeScreen.dart';
import 'package:brtsprojectapp/LogoutPage.dart';
import 'package:brtsprojectapp/MyAccountPage.dart';
import 'package:brtsprojectapp/MyPassPage.dart';
import 'package:brtsprojectapp/MyTicketPage.dart';
import 'package:brtsprojectapp/NewsDetails.dart';
import 'package:brtsprojectapp/OTPChecking.dart';
import 'package:brtsprojectapp/OffersPage.dart';
import 'package:brtsprojectapp/RegisterPage.dart';
import 'package:brtsprojectapp/SplashScreen.dart';
import 'package:brtsprojectapp/SupportPage.dart';
import 'package:brtsprojectapp/TicketBookPage.dart';
import 'package:brtsprojectapp/TicketDetail.dart';
import 'package:brtsprojectapp/TimeTablePage.dart';
import 'package:brtsprojectapp/WalletPage.dart';
import 'package:brtsprojectapp/PassDetail.dart';
import 'package:brtsprojectapp/AddPassScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:SplashScreen(),
      routes: {
        'TicketDetail': (BuildContext context) => TicketDetail(),
        'NewsDetails': (BuildContext context) => NewsDetails(),
        'AddTicket2': (BuildContext context) => AddTicket2(),
        'AddTicket': (BuildContext context) => Addticket(),
        'OTPChecking' : (BuildContext context)=>OTPChecking(),
        'ChangePassword' : (BuildContext context)=>ChangePasswordPage(),
        'Login' :(BuildContext context)=> LoginPage(),
      },
    );
  }
}
