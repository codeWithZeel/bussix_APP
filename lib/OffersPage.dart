import 'dart:convert';

import 'package:brtsprojectapp/UrlHelper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OffersPage extends StatefulWidget {
  @override
  _OffersPageState createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  Future<List> data;

  Future<List> getalldata() async {
    Uri url = Uri.parse(UrlHelper.GET_OFFERS);
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
        title: Text("OffersPage"),
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
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                              snapshot.data[position]["Description"].toString(),
                              style: TextStyle(fontSize: 18.0)),
                          subtitle: Text(
                              snapshot.data[position]["Title"].toString() +
                                  " | Discount: " +
                                  snapshot.data[position]["Discount"]
                                      .toString() +
                                  " | Amount: " +
                                  snapshot.data[position]["amount"].toString(),
                              style: TextStyle(fontSize: 15.0)),
                          trailing:
                              (snapshot.data[position]["Is_active"].toString() ==
                                      "yes")
                                  ? Icon(
                                      Icons.check,
                                      color: Colors.green,
                                      size: 30,
                                    )
                                  : Icon(
                                      Icons.clear,
                                      color: Colors.red,
                                      size: 30,
                                    ),
                        ),
                        Divider()
                      ],
                    ),
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
