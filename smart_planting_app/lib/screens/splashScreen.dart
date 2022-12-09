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
    Timer(Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                landingScreen()
            )
        )
    );
  }
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: false);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 500,
                alignment: Alignment.bottomCenter,
                color: Colors.white,
                child: Image.asset('asset/icon1.png' , cacheHeight: 200,),
            ),
            Container(
              color: Colors.white,
              alignment: Alignment.bottomCenter,
              height: 150,
              child: const Text(
                'Welcome',
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
      ),
    );
  }
}