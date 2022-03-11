import 'dart:convert';

import 'package:brtsprojectapp/UrlHelper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AllBusPage extends StatefulWidget {
  @override
  _AllBusPageState createState() => _AllBusPageState();
}

class _AllBusPageState extends State<AllBusPage> {
  Future<List> data;

  Future<List> getalldata() async {
    Uri url = Uri.parse(UrlHelper.ALL_BUS);
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
        title: Text("Bus List"),
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
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            elevation: 10.0,
                            child: Column(
                              children: [
                                Image.network(
                                  UrlHelper.busimagepath +
                                      snapshot.data[position]["Bus_photos"]
                                          .toString(),
                                  width: 300,
                                ),
                                Text("Bus Number: "+
                                  snapshot.data[position]["Bus_no"]
                                      .toString(),
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text("Bus Type: "+
                                  snapshot.data[position]["Bus_type"]
                                      .toString(),
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        )
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
