// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      home: Scaffold(
        appBar: AppBar(
          title: Text("Sample App"),
        ),
        body: Center(
          child: Text(
              "Smart Planting System",
          style: TextStyle(fontSize: 30.0),),
        ),
      ),
      );
  }
}