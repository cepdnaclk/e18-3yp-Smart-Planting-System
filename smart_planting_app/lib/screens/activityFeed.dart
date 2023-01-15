import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_planting_app/screens/post_Screen.dart';
import 'package:smart_planting_app/screens/profile.dart';
import 'package:smart_planting_app/screens/progress.dart';
import 'package:smart_planting_app/screens/register.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:timeago/timeago.dart' as timeago;

class activityFeed extends StatefulWidget {
  const activityFeed({Key? key}) : super(key: key);

  @override
  State<activityFeed> createState() => _activityFeedState();
}

class _activityFeedState extends State<activityFeed> {
  List<activityFeedItem> feedItemList = [];

  getAcivityFeed() async {
    QuerySnapshot snapshot = await activityFeedRef
        .doc(currentUser.id)
        .collection('feedItems')
        .orderBy('timestamp' , descending: true)
        .limit(50)
        .get();

    print('hellooooooooooooooooooooooo');
    //print(snapshot.docs.last.data());
    print(feedItemList.isEmpty);

    snapshot.docs.forEach((doc) {
      feedItemList.add(activityFeedItem.fromDocument(doc));
      //print('Activity feed items: ${docs.data()}');
    });


    return snapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black,),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Notifications", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        backgroundColor: Colors.green,
      ),
      body: Container(
        child: FutureBuilder(
          future: getAcivityFeed(),
          builder: (context , snapshot) {
            if(!snapshot.hasData) {
              return circularProgress();
            }
            return ListView(
              children: feedItemList,
            );
          },
        ),
      ),
    );
  }

}

late Widget mediaPreview;
late String activityItemText;

class activityFeedItem extends StatelessWidget {
  final String username;
  final String userId;
  final String type;
  final String mediaUrl;
  final String postId;
  final String userProfileImg;
  final String commentData;
  final Timestamp timestamp;

  const activityFeedItem({Key? key,
    required this.username,
    required this.userId,
    required this.type,
    required this.mediaUrl,
    required this.postId,
    required this.userProfileImg,
    required this.commentData,
    required this.timestamp,
  });

  factory activityFeedItem.fromDocument(DocumentSnapshot doc) {
    return activityFeedItem(
        username: doc['username'],
        userId: doc['userId'],
        type: doc['type'],
        mediaUrl: doc['mediaUrl'],
        postId: doc['postId'],
        userProfileImg: doc['userProfileImg'],
        commentData: doc['comment'],
        timestamp: doc['timestamp']
    );
  }

  showPost(context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context)
    => postScreen(userId: userId, postId: postId)));
  }

  configureMediaPreview(context) {
    if(type == 'like' || type == 'comment') {
      mediaPreview = GestureDetector(
        onTap: () => showPost(context),
        child: Container(
          height: 50,
          width: 50,
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(mediaUrl),
                )
              ),
            ),
          ),
        ),
      );
    } else {
      mediaPreview = const Text('');
    }
    
    if(type == 'like') {
      activityItemText = 'liked your post';
    } else if(type == 'follow') {
      activityItemText = 'is following you';
    } else if(type == 'comment') {
      activityItemText = 'replied: $commentData';
    } else {
      activityItemText = "Error: Unknown type '$type'";
    }
    
  }

  @override
  Widget build(BuildContext context) {
    configureMediaPreview(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Container(
        color: Colors.white54,
        child: ListTile(
          title: GestureDetector(
            onTap: () => showProfile(context, profileId: userId),
            child: RichText(
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14
                ),
              children: [
                TextSpan(
                  text: username,
                  style: const TextStyle(fontWeight: FontWeight.bold)
                ),
                TextSpan(
                    text: ' $activityItemText',
                ),
              ]
              ),
            ),
          ),
          leading: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(userProfileImg),
          ),
          subtitle: Text(
            timeago.format(timestamp.toDate()),
            overflow: TextOverflow.ellipsis,
          ),
          trailing: mediaPreview,
        ),
    ),
    );
  }
}

showProfile(BuildContext context, { required String profileId }) {
  Navigator.push(context, MaterialPageRoute(builder: (context) =>
  profileScreen(profileId: profileId)));
}

