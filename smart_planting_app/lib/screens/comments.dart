import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_planting_app/screens/custom_image.dart';
import 'package:smart_planting_app/screens/progress.dart';
import 'package:smart_planting_app/screens/register.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:timeago/timeago.dart' as timeago;

class comments extends StatefulWidget {
  final String postId;
  final String postOwnerId;
  final String postMediaUrl;

  comments({Key? key,
    required this.postId,
    required this.postOwnerId,
    required this.postMediaUrl,
  }) : super(key: key);

  @override
  State<comments> createState() => _commentsState(
    postId : this.postId,
    postOwnerId: this.postOwnerId,
    postMediaUrl: this.postMediaUrl
  );
}

class _commentsState extends State<comments> {
  TextEditingController commentController = TextEditingController();
  final String postId;
  final String postOwnerId;
  final String postMediaUrl;

  _commentsState({Key? key,
    required this.postId,
    required this.postOwnerId,
    required this.postMediaUrl,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black,),
        ),
        centerTitle: true,
        title: Text('Comments' , style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),),
      ),
      body: Column(
        children: [
          Expanded(
              child: buildComments()),
          Divider(),
          ListTile(
            title: TextFormField(
              controller: commentController,
              decoration: InputDecoration(labelText: "Write a comment...",),
            ),
            trailing: OutlinedButton(
              onPressed: () => addComment(),
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(side: BorderSide.none) //<-- SEE HERE
              ),
              child: Text('Post'),
            ),
          )
        ],
      ),
    );
  }

  buildComments() {
    return StreamBuilder(
      stream: commentRef.doc(postId).collection('comments')
          .orderBy("timestamp", descending: false).snapshots(),
        builder: (context, snapshot) {
        if(!snapshot.hasData) {
          return circularProgress();
        }
        List<comment> commentsList = [];
        snapshot.data!.docs.forEach((doc) {
          commentsList.add(comment.fromDocument(doc));
        });
        return ListView(
          children: commentsList,
        );

        });
  }

  addComment() {
    timestamp = DateTime.now();
    commentRef.doc(postId).collection("comments").add({
      "username" : currentUser.username,
      "comment" : commentController.text,
      "timestamp" : timestamp,
      "avatarUrl" : currentUser.photoUrl,
      "userId" : currentUser.id,
    });
    bool isNotPostOwner = currentUser.id != postOwnerId;
    if(isNotPostOwner) {
      activityFeedRef.doc(postOwnerId).collection('feedItems').add({
        "type": "comment",
        "comment" : commentController.text,
        "username": currentUser.username,
        "userId": currentUser.id,
        "userProfileImg": currentUser.photoUrl,
        "postId": postId,
        "mediaUrl": postMediaUrl,
        "timestamp": timestamp
      });
    }

    commentController.clear();
  }
}

class comment extends StatelessWidget {
  final String username;
  final String userId;
  final String avatarUrl;
  final String userComment;
  final Timestamp timestamp;

  const comment({Key? key,
    required this.username,
    required this.userId,
    required this.avatarUrl,
    required this.userComment,
    required this.timestamp
  } ) : super(key: key);

  factory comment.fromDocument(DocumentSnapshot doc) {
    return comment(
        username: doc['username'],
        userId: doc['userId'],
        avatarUrl: doc['avatarUrl'],
        userComment: doc['comment'],
        timestamp: doc['timestamp']
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(userComment),
          leading: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(avatarUrl),
          ),
          subtitle: Text(timeago.format(timestamp.toDate())),
        ),
        Divider(),
      ],
    );
  }
}

