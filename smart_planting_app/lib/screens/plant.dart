import 'package:flutter/material.dart';

class plantScreen extends StatefulWidget {
  const plantScreen({Key? key}) : super(key: key);

  @override
  State<plantScreen> createState() => _plantScreenState();
}

class _plantScreenState extends State<plantScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        centerTitle: true,
      ),
    );
  }
}
