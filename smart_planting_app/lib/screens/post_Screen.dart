import 'package:flutter/material.dart';
import 'package:smart_planting_app/screens/posts.dart';
import 'package:smart_planting_app/screens/progress.dart';
import 'package:smart_planting_app/screens/register.dart';

class postScreen extends StatelessWidget {
  final String userId;
  final String postId;

  const postScreen({Key? key, required this.userId, required this.postId});

  Future<posts?> readPost() async {
    final snapshot = await postsRef.doc(userId).collection('userPosts').doc(postId).get();

    if(snapshot.exists) {
      return posts.fromJson(snapshot.data()!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: readPost(),//postsRef.doc(userId).collection('userPosts').doc(postId).get(),
      builder: (context, snapshot) {
        if(!snapshot.hasData) {
          return circularProgress();
        }
        final post = snapshot.data;

        return Center(
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_outlined),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(
                  post!.caption,
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                  overflow: TextOverflow.ellipsis
                ,),
              backgroundColor: Colors.green,
            ),
            body: ListView(
              children: [
                Container(
                  child: post,
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
