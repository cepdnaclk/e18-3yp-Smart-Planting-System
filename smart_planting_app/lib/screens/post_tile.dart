import 'package:flutter/material.dart';
import 'package:smart_planting_app/screens/post_Screen.dart';
import 'package:smart_planting_app/screens/posts.dart';

class postTile extends StatelessWidget {
  final posts post;

  const postTile({Key? key, required this.post}) : super(key: key);

  showPost(context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context)
    => postScreen(userId: post.ownerId, postId: post.postId)));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showPost(context),
      child: Image.network(post.mediaUrl, cacheHeight: 120, cacheWidth: 118,),
    );
  }
}
