import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smart_planting_app/screens/landing.dart';

class splash extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<splash> with TickerProviderStateMixin{
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                landingScreen()
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          SizedBox(height: 80,),
          Container(
              height: 500,
              alignment: Alignment.center,
              child: Image.asset('asset/logo.png' , cacheHeight: 200,),
          ),
          SizedBox(height: 40,),
          Container(
            alignment: Alignment.center,
            child: const Text(
              'WELCOME',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}