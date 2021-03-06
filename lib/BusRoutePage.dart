import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:brtsprojectapp/UrlHelper.dart';
import 'package:http/http.dart' as http;

class BusRoutePage extends StatefulWidget {
  

  @override
  _BusRoutePageState createState() => _BusRoutePageState();
}

class _BusRoutePageState extends State<BusRoutePage> {

  Future<List> data;

  Future<List> getalldata() async
  {
    Uri url = Uri.parse(UrlHelper.BUS_ROUTES);
    var response = await http.get(url);
    if(response.statusCode==200)
    {
      var json = jsonDecode(response.body.toString());
      return json;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      data= getalldata();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BusRoutePage"),
      ),
      body: FutureBuilder(
        future: data,
        builder: (context,snapshot)
        {
          if(snapshot.hasData)
          {
            if(snapshot.data.length<=0)
            {
              return Center(child: Text("No Data"));
            }
            else
            {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context,position)
                {
                  return Card(
                    elevation: 5.0,
                    child: ListTile(
                      leading: Text("Route: "+snapshot.data[position]["Route_number"].toString(),style: TextStyle(fontSize: 20.0),),
                      title: Text("Bus Station: "+snapshot.data[position]["Bus_station_address"].toString()),
                      subtitle: Text("Timing: "+snapshot.data[position]["Bus_time"].toString()),
                    ),
                  );
                },
              );
            }
          }
          else
          {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
