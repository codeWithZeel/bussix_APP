import 'package:flutter/material.dart';

class NewsDetails extends StatefulWidget {

  @override
  _NewsDetailsState createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News Details"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 10.0,
                      child: Padding
                        (padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Image.asset("images/logo.png",width: 300,),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text("Motera Stadium is rename to Shree Narendra Modi Stadium",style: TextStyle(fontSize: 18.0)),
                            subtitle: Text("News",style: TextStyle(fontSize: 12.0)),
                          ),
                          Divider(height: 1),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
