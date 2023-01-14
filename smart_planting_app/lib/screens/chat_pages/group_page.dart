import 'package:smart_planting_app/screens/chat_pages/search_page.dart';
import 'package:flutter/material.dart';

import '../user_profile.dart';

class GroupPage extends StatefulWidget{
  const GroupPage({super.key});

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage>{
  bool _isLoading = false;
  String groupName = "";

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: (){
                //nextScreen(context,const SearchPage());
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SearchPage()));
              },
              icon: const Icon(
                  Icons.search,
              ))
        ],
        elevation: 0,
        centerTitle: true,
        //backgroundColor: Theme.of(context).primaryColor,
        backgroundColor: Colors.green,
        title: const Text(
            "Groups",
          style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold,fontSize: 27),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 50),
          children: <Widget>[
            Icon(
                Icons.account_circle,
                size: 150,
                color: Colors.grey[700],
            ),
            //CHECK !!!!!
            const Text(
              "userName",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            const Divider(
              height: 2,
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const GroupPage()));
              },
              //selectedColor: Theme.of(context).primaryColor,
              selectedColor: Colors.green,
              selected: true,
              contentPadding: 
                const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              leading: const Icon(Icons.group),
              title: const Text(
                "Groups",
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const profileScreen(name: '', about: '')));
                //Navigator.of(context).push(MaterialPageRoute(builder: (context) => const GroupPage()));
              },
              //selectedColor: Theme.of(context).primaryColor,
              selectedColor: Colors.green,
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              leading: const Icon(Icons.account_circle),
              title: const Text(
                "Profile",
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: (){
                //Navigator.of(context).push(MaterialPageRoute(builder: (context) => const GroupPage()));
              },
              //selectedColor: Theme.of(context).primaryColor,
              selectedColor: Colors.green,
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              leading: const Icon(Icons.logout),
              title: const Text(
                "Logout",
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
      body: groupList(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          popUpDialog(context);
        },
        elevation: 0,
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white,size: 30,),
      ) ,
    );
  }
  popUpDialog(BuildContext context){
    showDialog(
      barrierDismissible: false,
        context: context,
        builder: (context){
          return AlertDialog(
            title: const Text(
              "Create a group",
              textAlign: TextAlign.left,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _isLoading == true
                ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.green
                  ),
                )
                    : TextField(
                  onChanged: (val){
                    setState(() {
                      groupName = val;
                    });
                  },
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.green),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                )
              ],
            ),
            actions: [
              ElevatedButton(
                //HAVE TO IMPLEMENT!!!!!
                onPressed: (){},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text("CREATE"),
              ),

              ElevatedButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text("CANCEL"),
              )
            ],
          );
        });
  }
  groupList(){}
}
