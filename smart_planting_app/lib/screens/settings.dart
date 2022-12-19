import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_planting_app/AuthRepository/authRepo.dart';

class settingScreen extends StatefulWidget {
  const settingScreen({Key? key}) : super(key: key);

  @override
  State<settingScreen> createState() => _settingScreenState();
}

class _settingScreenState extends State<settingScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back, color: Colors.black,)),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const Text('Settings', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),),
              const SizedBox(height: 20,),
              Row(
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.green.shade300,
                  ),
                  const SizedBox(width: 8,),
                  const Text(
                    'Account',
                      style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),)
                ],
              ),
              const Divider(
                height: 15,
                thickness: 2,
              ),
              buildSettings(context, 'Change Password'),
              const SizedBox(height: 8,),
              buildSettings(context, 'Content Setting'),
              const SizedBox(height: 8,),
              buildSettings(context, 'Social'),
              const SizedBox(height: 8,),
              buildSettings(context, 'Language'),
              const SizedBox(height: 8,),
              buildSettings(context, 'Privacy and Security'),
              const SizedBox(height: 20,),

              Row(
                children: [
                  Icon(
                    Icons.notifications,
                    color: Colors.green.shade300,
                  ),
                  const SizedBox(width: 8,),
                  const Text(
                    'Notifications',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),)
                ],
              ),
              const Divider(
                height: 15,
                thickness: 2,
              ),

              buildSwitchSettings('New For You'),
              const SizedBox(height: 8,),
              buildSwitchSettings('Account Activity'),
              const SizedBox(height: 8,),
              buildSwitchSettings('Opportunity'),
              const SizedBox(height: 20,),


              Center(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    elevation: 0,
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  onPressed: () {
                    AuthenticationRepository.instance.logout();
                  },
                  child: Text(
                    'Log Out',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black, letterSpacing: 2.2),

                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }

  GestureDetector buildSettings(BuildContext context, String title) {
    return GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(title),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('example'),
                    ],
                  ),
                  actions: [
                    FloatingActionButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      child: const Text(
                        'Close',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15, color:
                        Colors.lightBlue),),),
                  ],


                );
              }
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black54
              ),
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward_ios, color: Colors.grey,))
          ],
        ),
      );
  }

  Widget buildSwitchSettings(String title) {
    return
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              color: Colors.black54,
            ),
          ),
          Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
                value: true,
                onChanged: (bool val) {}
            ),
          )

        ],
      );
  }
}
