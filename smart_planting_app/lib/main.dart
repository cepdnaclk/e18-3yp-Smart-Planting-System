// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'screens/splashScreen.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      theme: ThemeData.light(),
      //darkTheme: ThemeData.dark(),
      home: splash(),
    );
  }
}