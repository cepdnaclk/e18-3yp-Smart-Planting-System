import 'package:flutter/material.dart';

class GroupPage extends StatefulWidget{
  const GroupPage({super.key});

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        /*actions: [
          IconButton(
              onPressed: (){
                nextScreen(context,const SearchPage());
              },
              icon: const Icon(
                  Icons.search,
              ))
        ],*/
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
            "Groups",
          style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold,fontSize: 27),
        ),
      ),
    );
  }
}