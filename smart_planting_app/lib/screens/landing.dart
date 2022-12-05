import 'package:flutter/material.dart';

class landingScreen extends StatelessWidget {
  const landingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Smart Planting"),
          flexibleSpace: Image.asset("asset/appbar.jpg", fit: BoxFit.cover,),
        ),
        body: BottomAppBar(
          color: Colors.green,
        ),
      ),
    );
  }
}
