import 'package:flutter/material.dart';

class GroupInfo extends StatefulWidget{
  final String groupId;
  final String groupName;
  final String adminName;

  const GroupInfo (
      {Key? key,
        required this.groupId,
        required this.groupName,
        required this.adminName})
      : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}