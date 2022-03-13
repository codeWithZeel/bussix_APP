import 'dart:convert';

import 'package:brtsprojectapp/UrlHelper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LetestNewsPage extends StatefulWidget {


  @override
  _LetestNewsPageState createState() => _LetestNewsPageState();
}

class _LetestNewsPageState extends State<LetestNewsPage> {

  Future<List> data;

  Future<List> getalldata() async
  {
    Uri url = Uri.parse(UrlHelper.GET_NEWS);
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
        title: Text("LetestNewsPage"),
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
                itemBuilder: (context, position) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.of(context).pushNamed("NewsDetails",arguments: {"id":snapshot.data[position]["News_id"].toString()});
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Card(
                              elevation: 10.0,
                              child: Column(
                                children: [
                                  Image.network(
                                    UrlHelper.newsimagepath +
                                        snapshot.data[position]["News_img"]
                                            .toString(),
                                    width: 300,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      snapshot.data[position]
                                      ["Title"]
                                          .toString(),
                                      style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
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
