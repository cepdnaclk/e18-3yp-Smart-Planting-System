import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smart_planting_app/screens/community2.dart';
import 'package:smart_planting_app/screens/upload.dart';

class postWidget extends StatefulWidget {
  const postWidget({Key? key,}) : super(key: key);

  @override
  State<postWidget> createState() => _postWidgetState();
}

class _postWidgetState extends State<postWidget> {
  late String postCaption;
  bool isUploading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black,),
            onPressed: () => Navigator.pop(context),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                ),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => communityScreen2())),
                child: Text('Post', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),)
            )
          ],
        ),

        body: ListView(
          children: [
            isUploading ? LinearProgressIndicator() : Text(''),
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                height: 220,
                width: 250,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(file),
                      )
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                child: Image.asset('asset/profile.png'),
              ),
              title: Container(
                width: 250,
                child: TextField(
                  onChanged: (caption) {
                    postCaption = caption;
                  },
                  decoration: InputDecoration(
                    hintText: 'add a Caption...',
                    border: InputBorder.none,
                  )
                ),
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.pin_drop, color: Colors.red, size: 35,),
              title: Container(
                width: 250,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'where was the photo taken',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

}
