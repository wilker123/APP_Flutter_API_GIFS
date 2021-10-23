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
  //https://developers.giphy.com/branch/master/static/header-logo-8974b8ae658f704a5b48a2d039b8ad93.gif
  
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
  void initState() {
    // TODO: implement initState
    super.initState();
  
    _getSearch().then((value) => print(value));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
