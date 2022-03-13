import 'dart:convert';

import 'package:brtsprojectapp/AddComplain.dart';
import 'package:brtsprojectapp/UrlHelper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class ComplainPage extends StatefulWidget {

  @override
  _ComplainPageState createState() => _ComplainPageState();
}

class _ComplainPageState extends State<ComplainPage> {

  TextEditingController Uesrid = TextEditingController();
  TextEditingController Complain = TextEditingController();
  TextEditingController image = TextEditingController();


  Future<List> data;

  Future<List> getalldata() async
  {
    Uri url = Uri.parse(UrlHelper.GET_COMPLAIN);
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
        title: Text("ComplainPage"),
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
                    title: Text(snapshot.data[position]["Status"].toString()),
                    subtitle: Text(snapshot.data[position]["Com_text"].toString()),
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
        tooltip: "Add Complain",
        onPressed: (){
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context)=>AddComplain())
          );
        },
      ),
    );
  }
}
