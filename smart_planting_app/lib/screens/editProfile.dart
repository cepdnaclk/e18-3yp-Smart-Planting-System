import 'package:flutter/material.dart';
import 'package:smart_planting_app/Models/user.dart';
import 'package:smart_planting_app/screens/user_detail.dart';
import 'package:smart_planting_app/screens/user_profile.dart';

class editProfile extends StatelessWidget {
  editProfile({Key? key}) : super(key: key);

  String name = '';
  String about = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back, color: Colors.black,)),
        elevation: 0,
        actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.transparent,
              ),
              onPressed: ()
                => Navigator.of(context).push(MaterialPageRoute(builder: (context)
                => profileScreen(name: name, about: about))),
              child: const Text('Save', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),)
          )
        ],
      ),

      body: Container(
        margin: const EdgeInsets.all(24.0),
        child: Form(
          child: Column(
            children: [
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Edit Profile', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),)
              ),
              const SizedBox(height: 30,),
              Container(
                height: 40,
                width: 300,
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black54, ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),)
                    ),
                    alignLabelWithHint: false,
                    contentPadding: EdgeInsets.only(top: 5, left: 8, right: 5),
                    label: Text('User Name', style: TextStyle(fontSize: 15, color: Colors.black87),),
                    hintText: 'Type new User Name',
                    hintStyle: TextStyle(fontSize: 15, color: Colors.black54),
                  ),
                  style: const TextStyle(fontSize: 15, color: Colors.black),
                  onChanged: (username) {
                    name = username;
                  },
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 162,
                width: 300,
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black54, ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),)
                    ),
                    alignLabelWithHint: false,
                    contentPadding: EdgeInsets.only(top: 5, left: 8, right: 5),
                    label: Text('About', style: TextStyle(fontSize: 15, color: Colors.black87),),
                    hintText: 'Tell something about Yourself',
                    hintStyle: TextStyle(fontSize: 15, color: Colors.black54),
                  ),
                  style: const TextStyle(fontSize: 15, color: Colors.black),
                  maxLines: null,
                  onChanged: (inputabout) {
                    about = inputabout;
                  },
                ),
              ),
            ],
          ),

        ),
      )
    );
  }
}
