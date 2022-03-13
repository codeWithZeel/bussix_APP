import 'dart:convert';

import 'package:flutter/material.dart';

import 'UrlHelper.dart';
import 'package:http/http.dart' as http;
class AddPassScreen extends StatefulWidget {

  @override
  _AddPassScreenState createState() => _AddPassScreenState();
}

class _AddPassScreenState extends State<AddPassScreen> {
  String selctedstartstation;
  String selectendstation;
  List data = [];

  Future getallstation() async {
    var url = Uri.parse(UrlHelper.GET_BUS_STATION);
    var response = await http.post(url);
    var jsonbody = response.body;
    var jsondata = jsonDecode(jsonbody);

    setState(() {
      data = jsondata;
    });
    print(data);
  }

  @override
  void initState() {
    // TODO: implement initState
    getallstation();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Pass"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: DropdownButton(
                value: selctedstartstation,
                hint: Text("Select Start Station"),
                items: data.map((list) {
                  return DropdownMenuItem(
                    child: Text(list["Bus_station_address"]),
                    value: list["Bus_station_id"].toString(),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selctedstartstation = value;
                    print("Start:"+selctedstartstation);
                  });
                },
              ),
            ),
            Container(
              child: DropdownButton(
                value: selectendstation,
                hint: Text("Select Start Station"),
                items: data.map((list) {
                  return DropdownMenuItem(
                    child: Text(list["Bus_station_address"]),
                    value: list["Bus_station_id"].toString(),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectendstation = value;
                    print("End :"+selectendstation);
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
