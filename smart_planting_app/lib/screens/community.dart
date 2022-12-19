import 'package:flutter/material.dart';
import 'package:smart_planting_app/screens/home.dart';
import 'package:smart_planting_app/screens/upload.dart';
import 'package:smart_planting_app/screens/user_profile.dart';

class communityScreen extends StatefulWidget {
  const communityScreen({Key? key}) : super(key: key);

  @override
  State<communityScreen> createState() => _communityScreenState();
}

class _communityScreenState extends State<communityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => homeScreen())),
        ),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => profileScreen())),
              icon: Icon(Icons.person_pin, color: Colors.black,))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 90,
            child: Container(),
          ),
          Expanded(
            flex: 10,
            child: Center(
              child: IconButton(
                icon: Icon(Icons.add_box_outlined),
                iconSize: 30,
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => upload())),
              ),
            ),
          )
        ],
      ),



    );
  }
}
