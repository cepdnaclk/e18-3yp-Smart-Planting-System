// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Smart Planting System"),
            leading: IconButton(
              icon: Icon(Icons.menu), 
              onPressed: () { },
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.search), 
                  onPressed: () { },
                ),
                IconButton(
                  icon: Icon(Icons.more_vert), 
                  onPressed: () { },
                ),
              ],
            flexibleSpace: Image.asset(
              "assests/appbar.jpg",
              fit: BoxFit.cover, 
            ),
          ),
          body: Container(
              ),
        ),
      ),
      );
  }
}