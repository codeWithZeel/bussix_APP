import 'dart:convert';
import 'dart:io';

import 'package:brtsprojectapp/UrlHelper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PassDetail extends StatefulWidget {

  @override
  _PassDetailState createState() => _PassDetailState();
}

class _PassDetailState extends State<PassDetail> {
  bool loading = true;
  String start_bus_station,
      end_bus_station,
      km,
      total_amount,
      start_date,
      end_date,
      status,
      date;

  _getData(id) async {
    var url = Uri.parse(UrlHelper.GET_SINGLE_PASS);
    var response = await http.post(url, body: {"Pass_id": id});
    print("RESPONSE" + response.toString());
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      // print(data);
      setState(() {
        start_bus_station = data[0]["Bus_station_address"].toString();
        end_bus_station = data[0]["Bus_station_address"].toString();
        km = data[0]["KM"].toString();
        total_amount = data[0]["Total_amount"].toString();
        start_date = data[0]["Start_date"].toString();
        end_date = data[0]["end_date"].toString();
        status = data[0]["Status"].toString();
        date = data[0]["date"].toString();
        loading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  var pid="";
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    if (arguments != null) {
      setState(() {
         pid= arguments["Pass_id"];
        _getData(pid);
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Pass Detail"),
      ),
      body: (loading)
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                  child: Card(
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(start_bus_station,
                                style: TextStyle(fontSize: 18.0)),
                            subtitle: Text("Starting Bus Station"),
                          ),
                          Divider(height: 1),
                          ListTile(
                            title: Text(end_bus_station,
                                style: TextStyle(fontSize: 18.0)),
                            subtitle: Text("Ending Bus Station"),
                          ),
                          Divider(height: 1),
                          ListTile(
                            title: Text(km,
                                style: TextStyle(fontSize: 18.0)),
                            subtitle: Text("Total KM"),
                          ),
                          Divider(height: 1),
                          ListTile(
                            title: Text(total_amount,
                                style: TextStyle(fontSize: 18.0)),
                            subtitle: Text("Total Amount"),
                          ),
                          Divider(height: 1),
                          ListTile(
                            title: Text(start_date,
                                style: TextStyle(fontSize: 18.0)),
                            subtitle: Text("S_location_id"),
                          ),
                          Divider(height: 1),
                          ListTile(
                            title: Text(end_date,
                                style: TextStyle(fontSize: 18.0)),
                            subtitle: Text("E_location_id"),
                          ),
                          Divider(height: 1),
                          ListTile(
                            title: Text(status,
                                style: TextStyle(fontSize: 18.0)),
                            subtitle: Text("Status"),
                          ),
                          Divider(height: 1),
                          ListTile(
                            title: Text(date,
                                style: TextStyle(fontSize: 18.0)),
                            subtitle: Text("Date"),
                          ),
                          Divider(height: 1),
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

