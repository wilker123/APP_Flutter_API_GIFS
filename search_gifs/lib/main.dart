import 'package:flutter/material.dart';
import 'package:search_gifs/ui/homePage.dart';

void main(){
  runApp(MaterialApp(
    home: const HomePage(),
    theme: ThemeData(
      hintColor: Colors.amber,
      primaryColor: Colors.white,
      inputDecorationTheme: const InputDecorationTheme(
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        hintStyle: TextStyle(color: Colors.amber),
      )),
  ));
}
