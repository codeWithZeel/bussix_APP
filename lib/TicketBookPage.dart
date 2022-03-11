import 'dart:convert';

import 'package:brtsprojectapp/UrlHelper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class TicketBookPage extends StatefulWidget {

  @override
  _TicketBookPageState createState() => _TicketBookPageState();
}

class _TicketBookPageState extends State<TicketBookPage> {
  Future<List> data;

  Future<List> getalldata() async
  {
    Uri url = Uri.parse(UrlHelper.GET_TICKET);
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
        title: Text("TicketBookPage"),
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
                  return ListTile(
                    title: Text(snapshot.data[position]["Total_amount"].toString()),
                    subtitle: Text(snapshot.data[position]["Wallet_amount"].toString()),
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
