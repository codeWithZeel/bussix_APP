import 'dart:convert';


import 'package:brtsprojectapp/AddPass1.dart';
import 'package:brtsprojectapp/AddPassScreen.dart';
import 'package:brtsprojectapp/AddTicket1.dart';
import 'package:brtsprojectapp/HomeScreen.dart';
import 'package:brtsprojectapp/UrlHelper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyPassPage extends StatefulWidget {


  @override
  _MyPassPageState createState() => _MyPassPageState();
}

class _MyPassPageState extends State<MyPassPage> {

  Future<List> data;

  Future<List> getalldata() async
  {
    Uri url = Uri.parse(UrlHelper.GET_PASS);
    var response = await http.get(url);
    if(response.statusCode==200)
    {
      print("success");
      var json = jsonDecode(response.body.toString());
      print(json);
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
        title: Text("MyPassPage"),
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
                    title: Text(snapshot.data[position]["S_location_id"].toString()),
                    subtitle: Text(snapshot.data[position]["S_location_id"].toString()),
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
      floatingActionButton: FloatingActionButton(
        child: Text("+",style: TextStyle(fontSize: 25),),
        tooltip: "My pass",
        onPressed: (){
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context)=>AddPass1())
          );
        },
      ),
    );
  }
}


