import 'package:flutter/material.dart';
import 'package:smart_planting_app/screens/custom_image.dart';
import 'package:smart_planting_app/screens/posts.dart';

class postTile extends StatelessWidget {
  final posts post;

  const postTile({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print('showing post'),
      child: Image.network(post.mediaUrl, cacheHeight: 120, cacheWidth: 118,),
    );
  }
}
