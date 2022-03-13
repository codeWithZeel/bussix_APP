import 'dart:convert';

import 'package:brtsprojectapp/AddTicket2.dart';
import 'package:brtsprojectapp/UrlHelper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddTicket1 extends StatefulWidget {
  @override
  _AddTicket1State createState() => _AddTicket1State();
}

class _AddTicket1State extends State<AddTicket1> {
  Future<List> data;

  Future<List> getalldata() async {
    Uri url = Uri.parse(UrlHelper.GET_BUS_STATION);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body.toString());
      return json;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      data = getalldata();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Start Location"),
      ),
      body: FutureBuilder(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length <= 0) {
              return Center(child: Text("No Data"));
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, position) {
                  return SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ListTile(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => AddTicket2(
                                        stid: snapshot.data[position]
                                                ["Bus_station_id"]
                                            .toString())));
                              },
                              title: Text(
                                  snapshot.data[position]["Bus_station_address"]
                                      .toString(),
                                  style: TextStyle(fontSize: 18.0)),
                              subtitle: Text(
                                  snapshot.data[position]["Bus_station_address"]
                                      .toString(),
                                  style: TextStyle(fontSize: 15.0)),
                              trailing: Icon(Icons.arrow_forward_ios,
                                  color: Colors.blue, size: 20),
                            ),
                            Divider()
                          ],
                        )),
                  );
                },
              );
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
