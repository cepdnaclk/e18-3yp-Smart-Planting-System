import 'package:flutter/material.dart';

class GroupTile extends StatefulWidget {
  final String userName;
  final String groupId;
  final String groupName;

  const GroupTile({Key?key,
    required this.groupId,
    required this.groupName,
    required this.userName})
      : super(key: key);

  @override
  State<GroupTile> createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupTile>{
  @override
  Widget build(BuildContext context){
    return ListTile(
      title: Text(widget.groupId),
      subtitle: Text(widget.groupName),
    );
  }
}