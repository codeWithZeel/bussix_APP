import 'dart:convert';

import 'package:brtsprojectapp/UrlHelper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TicketDetail extends StatefulWidget {
  @override
  _TicketDetailState createState() => _TicketDetailState();
}

class _TicketDetailState extends State<TicketDetail> {
  bool loading = true;
  String start_bus_station,
      end_bus_station,
      km,
      total_amount,
      transaction,
      status,
      date,
      tid;

  _getData(id) async {
    var url = Uri.parse(UrlHelper.GET_SINGLE_TICKET);
    var response = await http.post(url, body: {"Ticket_id": id});
    print("RESPONSE" + response.toString());
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      // print(data);
      setState(() {
        start_bus_station = data[0]["Bus_station_address"].toString();
        end_bus_station = data[0]["Bus_station_address"].toString();
        km = data[0]["KM"].toString();
        total_amount = data[0]["Total_amount"].toString();
        transaction = data[0]["Transaction_no"].toString();
        status = data[0]["Status"].toString();
        date = data[0]["P_book_datetime"].toString();
        loading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    if (arguments != null) {
      setState(() {
        tid = arguments["Ticket_id"];
        _getData(tid);
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Tikcet Detail"),
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
                              title: Text(transaction,
                                  style: TextStyle(fontSize: 18.0)),
                              subtitle: Text("Transaction ID"),
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
