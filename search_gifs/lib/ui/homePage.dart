// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  String _search = "";
  int offset = 0;

  Future<Map> _getSearch() async {
    http.Response response;

    if(_search == ""){
      response = await http.get(Uri.parse("https://api.giphy.com/v1/gifs/trending?api_key=7Qkw02pqZWcO2ZooCKA6dmLkKFhDrtkB&limit=20&rating=g"));
    }else{
      response = await http.get(Uri.parse("https://api.giphy.com/v1/gifs/search?api_key=7Qkw02pqZWcO2ZooCKA6dmLkKFhDrtkB&q=$_search&limit=19&offset=$offset++&rating=g&lang=en"));
    }

    return json.decode(response.body);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.network("https://developers.giphy.com/branch/master/static/header-logo-8974b8ae658f704a5b48a2d039b8ad93.gif"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
           const Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Pesquise aqui...",
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder()
              ),
              style: TextStyle(color: Colors.white, fontSize: 18.0),
              textAlign: TextAlign.center
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: _getSearch(),
              builder: (context, snapshot){
                switch(snapshot.connectionState){
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return Container(
                      width: 200.0,
                      height: 200.0,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 5.0,
                      ),
                    );
                  default:
                    if(snapshot.hasError){
                      return Container();
                    }else{
                      return _gridTableGifs(context, snapshot);
                    }

                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _gridTableGifs(BuildContext context, AsyncSnapshot snapshot){
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0
      ),
      itemCount: snapshot.data['data'].length,
      itemBuilder: (context, index){
        return GestureDetector(
          child: Image.network(snapshot.data['data'][index]['images']['fixed_height']['url'],
          height: 300.0, fit: BoxFit.cover),
        );
      }
    );
  }

}
