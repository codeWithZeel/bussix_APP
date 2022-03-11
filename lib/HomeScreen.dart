import 'package:brtsprojectapp/AddComplain.dart';
import 'package:brtsprojectapp/AllBusPage.dart';
import 'package:brtsprojectapp/BookYourPassPage.dart';
import 'package:brtsprojectapp/BusRoutePage.dart';
import 'package:brtsprojectapp/ChangePasswordPage.dart';
import 'package:brtsprojectapp/ComplainPage.dart';
import 'package:brtsprojectapp/LetestNewsPage.dart';
import 'package:brtsprojectapp/LoginPage.dart';
import 'package:brtsprojectapp/LogoutPage.dart';
import 'package:brtsprojectapp/MyAccountPage.dart';
import 'package:brtsprojectapp/MyPassPage.dart';
import 'package:brtsprojectapp/MyTicketPage.dart';
import 'package:brtsprojectapp/OffersPage.dart';
import 'package:brtsprojectapp/SupportPage.dart';
import 'package:brtsprojectapp/TicketBookPage.dart';
import 'package:brtsprojectapp/TimeTablePage.dart';
import 'package:brtsprojectapp/AddTicket.dart';
import 'package:brtsprojectapp/WalletPage.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username,email;

  _getvalue()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("name");
      email =prefs.getString("email");
    });
    print(username);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getvalue();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                child: Text(username.substring(0,1).toUpperCase()),
              ),
              accountName: Text("Welcome, "+username),
              accountEmail: Text("Email: "+email),
            ),
            ListTile(
              leading: Icon(Icons.home_filled),
              title: Text("All Bus"),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context)=>AllBusPage())
                );
              },
            ),
            Divider(),
            // ListTile(
            //   leading: Icon(Icons.tab_sharp),
            //   title: Text("Ticket Book"),
            //   onTap: (){
            //     Navigator.of(context).pop();
            //     Navigator.of(context).push(
            //       MaterialPageRoute(builder: (context)=>TicketBookPage())
            //     );
            //   },
            // ),
            // Divider(),
            //
            // ListTile(
            //   leading: Icon(Icons.paste_sharp),
            //   title: Text("Book Your Pass"),
            //   onTap: (){
            //     Navigator.of(context).pop();
            //     Navigator.of(context).push(
            //         MaterialPageRoute(builder: (context)=>BookYourPassPage())
            //     );
            //   },
            // ),
            // Divider(),

            ListTile(
              leading: Icon(Icons.card_travel),
              title: Text("My ticket"),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>MyTicketPage())
                );
              },
            ),
            Divider(),

            ListTile(
              leading: Icon(Icons.app_registration),
              title: Text("My pass"),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>MyPassPage())
                );
              },
            ),

            Divider(),
            ListTile(
              leading: Icon(Icons.route),
              title: Text("Bus Route"),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>BusRoutePage())
                );
              },
            ),
            Divider(),

            ListTile(
              leading: Icon(Icons.help),
              title: Text("Support"),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>SupportPage())
                );
              },
            ),
            Divider(),

            // ListTile(
            //   leading: Icon(Icons.comment_outlined),
            //   title: Text("Add complain"),
            //   onTap: (){
            //     Navigator.of(context).pop();
            //     Navigator.of(context).push(
            //         MaterialPageRoute(builder: (context)=>AddComplain())
            //     );
            //   },
            // ),
            // Divider(),


            ListTile(
              leading: Icon(Icons.sentiment_dissatisfied),
              title: Text("My Complain"),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>ComplainPage())
                );
              },
            ),
            Divider(),

            ListTile(
              leading: Icon(Icons.local_offer_sharp),
              title: Text("Offers"),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>OffersPage())
                );
              },
            ),
            Divider(),

            ListTile(
              leading: Icon(Icons.data_usage),
              title: Text("Latest News"),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>LetestNewsPage())
                );
              },
            ),
            Divider(),

            ListTile(
              leading: Icon(Icons.schedule),
              title: Text("Time Table"),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>TimeTablePage())
                );
              },
            ),
            Divider(),

            ListTile(
              leading: Icon(Icons.account_balance_wallet),
              title: Text("Wallet"),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>WalletPage())
                );
              },
            ),
            Divider(),


            // ListTile(
            //   leading: Icon(Icons.account_box_outlined),
            //   title: Text("My Account"),
            //   onTap: (){
            //     Navigator.of(context).pop();
            //     Navigator.of(context).push(
            //         MaterialPageRoute(builder: (context)=>MyAccountPage())
            //     );
            //   },
            // ),
            // Divider(),

            ListTile(
              leading: Icon(Icons.password_outlined),
              title: Text("Change Password"),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>ChangePasswordPage())
                );
              },
            ),
            Divider(),

            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Log out"),
              onTap: () async{
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.clear();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>LoginPage())
                );
              },
            ),
            Divider(),
          ],
        ),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(21.170240,72.831062),
          zoom: 14.4746,
        ),
        onMapCreated: (GoogleMapController controller) {

        },
      ),
    );
  }
}
