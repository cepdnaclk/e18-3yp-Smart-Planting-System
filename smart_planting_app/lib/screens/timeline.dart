import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_planting_app/screens/activityFeed.dart';
import 'package:smart_planting_app/screens/chat_pages/group_page.dart';
import 'package:smart_planting_app/screens/home.dart';
import 'package:smart_planting_app/screens/posts.dart';
import 'package:smart_planting_app/screens/profile.dart';
import 'package:smart_planting_app/screens/progress.dart';
import 'package:smart_planting_app/screens/register.dart';
import 'package:smart_planting_app/screens/search.dart';
import 'package:smart_planting_app/screens/upload.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:smart_planting_app/screens/user.dart';

class timelineScreen extends StatefulWidget {
  const timelineScreen({Key? key}) : super(key: key);

  @override
  State<timelineScreen> createState() => _timelineScreenState();
}

class _timelineScreenState extends State<timelineScreen> {
  List<posts> postsList = [];
  List<String> followingList = [];

  @override
  void initState() {
    super.initState();
    getTimeline();
    getFollowing();
  }

  getTimeline() async {
    QuerySnapshot snapshot = await timelineRef
        .doc(currentUser.id)
        .collection('timelinePosts')
        .get();

    List<posts> postsList = snapshot.docs
        .map((doc) => posts.fromDocument(doc))
        .toList();

    setState(() {
      this.postsList = postsList;
    });
  }

  getFollowing() async {
    QuerySnapshot snapshot = await followersRef
        .doc(currentUser.id)
        .collection('userFollowing')
        .get();

    setState(() {
      followingList = snapshot.docs
          .map((doc) => doc.id)
          .toList();
    });
  }

  buildTimeline() {
    if (postsList == null) {
      return circularProgress();
    } else if (postsList.isEmpty) {
      return buildUsersToFollow();
    } else {
      return ListView(children: postsList,);
    }
  }

  buildUsersToFollow() {
    return StreamBuilder(
      stream: usersRef.orderBy('username', descending: false).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
        List<UserResult> userResults = [];
        snapshot.data!.docs.forEach((doc) {
          AppUser newUser = AppUser.fromDocument(doc);
          final bool isAuthUser = currentUser.id == newUser.id;
          final bool isFollowingUser = followingList.contains(newUser.id);

          if (isAuthUser) {
            return;
          } else if (isFollowingUser) {
            return;
          } else {
            UserResult userResult = UserResult(newUser);
            userResults.add(userResult);
          }
        });

        return Container(
          color: Colors.green.shade50,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.person_add,
                        color: CupertinoColors.systemGreen,
                        size: 30,
                      ),
                      SizedBox(width: 8,),
                      Text(
                        'Users to Follow',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30
                        ),
                      )
                    ],
                  ),
                ),
                Column(children: userResults,)
              ],
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
              'Timeline',
          style: TextStyle(
            color: Colors.black,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold
          ),),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.green,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () =>
                    Navigator.of(context).push(MaterialPageRoute(builder: (
                        context) =>
                    const GroupPage())),
                icon: Image.asset('asset/msg.png')
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
              flex: 90,
              child: Container(
                  //padding: const EdgeInsets.symmetric(horizontal: 5),
                  height: double.infinity,
                  child: RefreshIndicator(
                    onRefresh: () => getTimeline(),
                    child: buildTimeline(),
                  )
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                color: Colors.green,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.home_filled, color: Colors.black,),
                      onPressed: () =>
                          Navigator.of(context).push(MaterialPageRoute(builder: (
                              context) => const homeScreen())),
                    ),
                    IconButton(
                      icon: const Icon(Icons.search, color: Colors.black,),
                      onPressed: () =>
                          Navigator.of(context).push(MaterialPageRoute(builder: (
                              context) => const searchScreen())),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_box_outlined),
                      iconSize: 30,
                      onPressed: () =>
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (
                                  context) => const upload())),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.notifications_active_outlined, color: Colors.black,),
                      onPressed: () =>
                          Navigator.of(context).push(MaterialPageRoute(builder: (
                              context) => const activityFeed())),
                    ),
                    IconButton(
                      icon: CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(
                            currentUser.photoUrl),
                      ),
                      color: CupertinoColors.activeGreen,
                      iconSize: 30,
                      onPressed: () =>
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) =>
                              profileScreen(profileId: currentUser.id,))),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}


class UserResult extends StatelessWidget {
final AppUser user;

UserResult(this.user);

@override
Widget build(BuildContext context) {
  return Container(
    child: Column(
      children: [
        GestureDetector(
          onTap: () => showProfile(context, profileId: user.id),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(user.photoUrl),
            ),
            title: Text(user.username, style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold,
            ),),
          ),
        ),
        const Divider(
          color: Colors.white54,
          height: 2,
        )
      ],
    ),
  );
}
}
