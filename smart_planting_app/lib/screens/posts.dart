import 'dart:async';

import 'package:animator/animator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:smart_planting_app/screens/activityFeed.dart';
import 'package:smart_planting_app/screens/comments.dart';
import 'package:smart_planting_app/screens/progress.dart';
import 'package:smart_planting_app/screens/register.dart';
import 'package:smart_planting_app/screens/user.dart';
import 'package:cached_network_image/cached_network_image.dart';

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

  static posts fromJson(Map<String, dynamic> json) => posts(
      postId: json['postId'],
      ownerId: json['ownerId'],
      username: json['username'],
      location: json['location'],
      caption: json['caption'],
      mediaUrl: json['mediaUrl'],
      likes: json['likes']
  );

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
  late bool isLiked;
  bool showHeart = false;

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
    final snapshot = await usersRef.doc(ownerId).get();

    if(snapshot.exists) {
      return AppUser.fromJson(snapshot.data()!);
    }
  }

  buildPostHeader() {
    return FutureBuilder<AppUser?> (
        future: readUser(),
        builder: (context, snapshot) {
          if(snapshot.hasError) {
            return Text('something went wrong! ${snapshot.error}');
          }
          else if(snapshot.hasData) {
            final newUser = snapshot.data;
            bool isPostOwner = currentUser.id == ownerId;

            return ListTile(
              leading: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(newUser!.photoUrl),
                backgroundColor: Colors.grey,
              ),
              title: GestureDetector(
                onTap: () => showProfile(context, profileId: newUser.id),
                child: Text(
                  newUser.username,
                  style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              subtitle: Text(location),
              trailing: isPostOwner ? IconButton(
                onPressed: () => handleDeletePost(context),
                icon: const Icon(Icons.more_vert),
              ) : Text(''),
            );
          }
          else {
            return Center(child: circularProgress(),);
          }
        }
    );
  }

  handleDeletePost(BuildContext parentContext) {
    return showDialog(
        context: parentContext,
        builder: (context) {
          return SimpleDialog(title: Text('Remove this Post?'),
          children: [
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
                deletePost();
              },
              child: Text('Delete',
              style: TextStyle(color: Colors.red),),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel',
                style: TextStyle(color: Colors.lightBlue),),
            )
          ],
          );
        });
  }

  deletePost() async {
    postsRef
        .doc(ownerId)
        .collection('userPosts')
        .doc(postId).get().then((doc) => {
          if(doc.exists) {
            doc.reference.delete()
          }
    });

    storageRef.child("posts/$postId.jpg").delete();

    QuerySnapshot activityFeedSnapshot = await activityFeedRef
        .doc(ownerId)
        .collection('feedItem')
        .where('postId', isEqualTo: postId)
        .get();
    activityFeedSnapshot.docs.forEach((doc) {
      if(doc.exists) {
        doc.reference.delete();
    }
    });
    QuerySnapshot commentsSnapshot = await commentRef
        .doc(postId)
        .collection('comments')
        .get();
    commentsSnapshot.docs.forEach((doc) {
      if(doc.exists) {
      doc.reference.delete();
    }
    });

  }

  handleLikePost() {
    String currentUserId = currentUser.id;
    bool _isLiked = likes[currentUser.id] == true;

    if(_isLiked) {
      postsRef
        .doc(ownerId)
        .collection('userPosts')
        .doc(postId)
        .update({
        'likes.$currentUserId': false
      });
      removeLikeToActivityFeed();
      setState(() {
        likeCount -= 1;
        isLiked = false;
        likes[currentUser.id] = false;
      });
    } else if(!_isLiked) {
      postsRef
          .doc(ownerId)
          .collection('userPosts')
          .doc(postId)
          .update({
        'likes.$currentUserId': true
      });
      addLikeToActivityFeed();
      setState(() {
        likeCount += 1;
        isLiked = true;
        showHeart = true;
        likes[currentUser.id] = true;
      });
      Timer(const Duration(milliseconds: 500), () {
        setState(() {
          showHeart = false;
        });
      });
    }

  }

  addLikeToActivityFeed() {
    timestamp = DateTime.now();
    bool isNotPostOwner = currentUser.id != ownerId;
    if(isNotPostOwner) {
      activityFeedRef.doc(ownerId).collection('feedItems').doc(postId).set({
        "type": "like",
        "comment" : "",
        "username": currentUser.username,
        "userId": currentUser.id,
        "userProfileImg": currentUser.photoUrl,
        "postId": postId,
        "mediaUrl": mediaUrl,
        "timestamp": timestamp
      });
    }
  }

  removeLikeToActivityFeed() {
    bool isNotPostOwner = currentUser.id != ownerId;
    if(!isNotPostOwner) {
      activityFeedRef.doc(ownerId).collection('feedItems').doc(postId).get()
          .then((doc) => {
        if(doc.exists) {
          doc.reference.delete()
        }
      });
    }
  }

  buildPostImage() {
    return GestureDetector(
      onDoubleTap: () => handleLikePost(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.network(mediaUrl),
          showHeart ? Animator(
            duration: Duration(milliseconds: 300),
            tween: Tween(begin: 0.8, end: 1.4),
            curve: Curves.elasticOut,
            cycles: 0,
            builder: (BuildContext context, AnimatorState<dynamic> animatorState, Widget? child) {
                return Transform.scale(
                  scale: 2,
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 80,),
                );
            },
          ) : const Text("")
          // showHeart ? const Icon(
          //   Icons.favorite,
          //   color: Colors.red,
          //   size: 80,)
          //     : const Text(""),
        ],
      ),
    );
  }

  showComments(BuildContext context, {required String postId, required String ownerId, required String mediaUrl}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return comments(
        postId: postId,
        postOwnerId: ownerId,
        postMediaUrl: mediaUrl,
      );
    }));
  }

  buildPostFooter() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.only(top: 40, left: 20)),
            GestureDetector(
              onTap: () => handleLikePost(),
              child: Icon(
                isLiked ? Icons.favorite : Icons.favorite_border,
                size: 28,
                color: Colors.red,
              ),
            ),
            const Padding(padding: EdgeInsets.only(right: 20)),
            GestureDetector(
              onTap: () => showComments(
                context,
                postId: postId,
                ownerId: ownerId,
                mediaUrl: mediaUrl,
              ),
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
              margin: const EdgeInsets.only(left: 20),
              child: Text(
                "$likeCount likes",
                style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold
                ),
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: Text(
                "$username ",
                style: const TextStyle(
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
    isLiked = (likes[currentUser.id] == true);

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
