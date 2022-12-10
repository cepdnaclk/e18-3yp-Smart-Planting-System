import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/second_screen.dart';

class homepage extends StatelessWidget{
  const homepage({super.key});

  @override
  Widget build(BuildContext context) {
    int count = 0;

    void increament(){
      count = count + 1;
    }
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
          body: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "No. of times the button pressed:",
                    style: TextStyle(
                        fontSize: 20.0),
                  ),
                  Text(""
                      "$count",
                    style: TextStyle(
                        fontSize: 20.0),
                  )
                ],)
          ),
          floatingActionButton: IconButton(
            icon: Icon(
              Icons.add,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return SecondScreen();
                  }
              )
              );
            },
            color: Colors.lightGreen,
          ),
        ),
      ),
    );
  }
}