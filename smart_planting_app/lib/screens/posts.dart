import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:smart_planting_app/screens/custom_image.dart';
import 'package:smart_planting_app/screens/progress.dart';
import 'package:smart_planting_app/screens/register.dart';
import 'package:smart_planting_app/screens/search.dart';
import 'package:smart_planting_app/screens/user.dart';

class posts extends StatefulWidget {
  final String postId;
  final String ownerId;
  final String username;
  final String location;
  final String caption;
  final String mediaUrl;
  final dynamic likes;

  posts({Key? key,
    required this.postId,
    required this.ownerId,
    required this.username,
    required this.location,
    required this.caption,
    required this.mediaUrl,
    required this.likes
  }) : super(key: key);

  factory posts.fromDocument(DocumentSnapshot doc) {
    return posts(
      postId: doc['postId'],
      ownerId: doc['ownerId'],
      username: doc['username'],
      location: doc['location'],
      caption: doc['caption'],
      mediaUrl: doc['mediaUrl'],
      likes: doc['likes'],
    );
  }

  int getLikeCount(likes) {
    if(likes == null) {
      return 0;
    }
    int count = 0;
    likes.values.forEach((val) {
      if(val == true) {
        count += 1;
      }
    });
    return count;
  }

  @override
  State<posts> createState() => _postsState(
      postId: this.postId,
      ownerId: this.ownerId,
      username: this.username,
      location: this.location,
      caption: this.caption,
      mediaUrl: this.mediaUrl,
      likeCount: getLikeCount(this.likes),
      likes: this.likes
  );
}

class _postsState extends State<posts> {
  final String postId;
  final String ownerId;
  final String username;
  final String location;
  final String caption;
  final String mediaUrl;
  int likeCount;
  Map likes;

  _postsState({Key? key,
    required this.postId,
    required this.ownerId,
    required this.username,
    required this.location,
    required this.caption,
    required this.mediaUrl,
    required this.likeCount,
    required this.likes
  });

  Future<AppUser?> readUser() async {
    final snapshot = await docUser.doc(ownerId).get();

    if(snapshot.exists) {
      return AppUser.fromJson(snapshot.data()!);
    }
  }

  buildPostHeader() {
    return FutureBuilder<AppUser?> (
        future: readUser(),//usersRef.doc(ownerId).get(),
        builder: (context, snapshot) {
          if(snapshot.hasError) {
            return Text('something went wrong! ${snapshot.error}');
          }
          else if(snapshot.hasData) {
            final newUser = snapshot.data;

            return ListTile(
              leading: CircleAvatar(
                child: Image.asset('asset/profile.png'),
                backgroundColor: Colors.grey,
              ),
              title: GestureDetector(
                onTap: () => print('show profile'),
                child: Text(
                  newUser!.username,
                  style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              subtitle: Text(location),
              trailing: IconButton(
                onPressed: () => print('deleting post'),
                icon: Icon(Icons.more_vert),
              ),
            );
          }
          else {
            return Center(child: circularProgress(),);
          }
        }
    );
  }

  buildPostImage() {
    return GestureDetector(
      onDoubleTap: () => print('liking post'),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.network(mediaUrl),
        ],
      ),
    );
  }

  buildPostFooter() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.only(top: 40, left: 20)),
            GestureDetector(
              onTap: () => print('liking post'),
              child: Icon(
                Icons.favorite_border,
                size: 28,
                color: Colors.red,
              ),
            ),
            Padding(padding: EdgeInsets.only(right: 20)),
            GestureDetector(
              onTap: () => print('showing comments'),
              child: Icon(
                Icons.chat,
                size: 28,
                color: Colors.blue[900],
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Text(
                "$likeCount likes",
                style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold
                ),
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Text(
                "$username ",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold
                ),
              ),
            ),
            Expanded(child: Text(caption))
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildPostHeader(),
        buildPostImage(),
        buildPostFooter(),
      ],
    );
  }
}
