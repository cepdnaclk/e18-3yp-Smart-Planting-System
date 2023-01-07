import 'package:chat_app/pages/group_info.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget{
  final String groupId;
  final String groupName;
  final String userName;

  const ChatPage (
  {Key? key,
    required this.groupId,
    required this.groupName,
    required this.userName})
    : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>{

  //Stream<QuerySnapshot>? chats;
  String admin = "";

  @override
  void initState(){
    getChatandAdmin();
    super.initState();
  }

  getChatandAdmin(){

  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(widget.groupName),
        backgroundColor: Colors.green,
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const GroupInfo(
                groupId: widget.groupId,
                groupName: widget.groupName,
                adminName: admin)));
          }, icon: const Icon(Icons.info))
        ],
      ),
    );
  }
}