import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_planting_app/screens/chat_pages/group_page.dart';
import 'package:smart_planting_app/screens/editProfile.dart';
import 'package:smart_planting_app/screens/post_tile.dart';
import 'package:smart_planting_app/screens/posts.dart';
import 'package:smart_planting_app/screens/progress.dart';
import 'package:smart_planting_app/screens/register.dart';
import 'package:smart_planting_app/screens/timeline.dart';
import 'package:smart_planting_app/screens/user.dart';


class profileScreen extends StatefulWidget {
  final String profileId;

  const profileScreen({Key? key, required this.profileId}) : super(key: key);

  @override
  State<profileScreen> createState() => _profileScreenState(profileId: profileId);
}

class _profileScreenState extends State<profileScreen> {
  final String profileId;
  final String currentProfileId = currentUser.id;
  String postOrientation = 'grid';
  bool isFollowing = false;
  bool isLoading = false;
  int postCount = 0;
  int followerCount = 0;
  int followingCount = 0;

  List<posts> postsList = [];

  _profileScreenState({Key? key, required this.profileId});

  @override
  void initState() {
    super.initState();
    getProfilePost();
    getFollowers();
    getFollowing();
    checkIfFollowing();
  }

  checkIfFollowing() async {
    DocumentSnapshot doc = await followersRef.doc(profileId)
        .collection('userFollowers')
        .doc(currentProfileId)
        .get();
    setState(() {
      isFollowing = doc.exists;
    });
  }

  getFollowers() async {
    QuerySnapshot snapshot = await followersRef.doc(profileId)
        .collection('userFollowers')
        .get();

    setState(() {
      followerCount = snapshot.docs.length;
    });
  }

    getFollowing() async {
      QuerySnapshot snapshot = await followingRef.doc(profileId)
          .collection('userFollowing')
          .get();

      setState(() {
        followingCount = snapshot.docs.length;
      });
    }

  getProfilePost() async {
    setState(() {
      isLoading = true;
    });
    QuerySnapshot snapshot = await postsRef
        .doc(profileId)
        .collection('userPosts')
        .orderBy("timestamp", descending: true).get();

    setState(() {
      isLoading = false;
      postCount = snapshot.docs.length;
      postsList = snapshot.docs.map((doc) => posts.fromDocument(doc)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black,),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text("Profile", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.of(context).push(MaterialPageRoute(builder: (
                      context) =>
                  const GroupPage())),
              icon: Image.asset('asset/msg.png')
          ),
          IconButton(
            icon: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Image.asset('asset/community.png', scale: 5,),
            ),
            color: Colors.black,
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const timelineScreen())),
          ),
        ],
      ),
      body: ListView(
        children: [
          buildProfileHeader(),
          const Divider(),
          buildTogglePostOrientation(),
          const Divider(),
          buildProfilePost(),
        ],
      ),
    );
  }

  buildProfilePost() {
    if(isLoading) {
      return circularProgress();
    } else if(postOrientation == "grid") {
      List<GridTile> gridTiles = [];
      postsList.forEach((post) {
        gridTiles.add(GridTile(child: postTile(post: post)));
      });
      return GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 1,
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: gridTiles,
      );
    } else if(postOrientation == "list") {
      return Column(
        children: postsList,
      );
    }

  }

  buildTogglePostOrientation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
            color: postOrientation == "grid" ? CupertinoColors.activeBlue : Colors.grey,
            onPressed: () => setPostOrientation('grid'),
            icon: const Icon(Icons.grid_on,)),
        IconButton(
            color: postOrientation == "list" ? CupertinoColors.activeBlue : Colors.grey,
            onPressed: () => setPostOrientation('list'),
            icon: const Icon(Icons.list,)),
      ],
    );
  }

  setPostOrientation(String postOrientation) {
    setState(() {
      this.postOrientation = postOrientation;
    });
  }

  Future<AppUser?> readUser() async {
    final snapshot = await usersRef.doc(profileId).get();

    if(snapshot.exists) {
      return AppUser.fromJson(snapshot.data()!);
    }
  }

  buildProfileHeader() {
    return FutureBuilder(
        future: readUser(),
        builder: (context, snapshot) {
            if(!snapshot.hasData) {
                return Text('something went wrong! ${snapshot.error}');
            }
            AppUser? newUser = snapshot.data;

            return Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.green.shade200,
                      backgroundImage: CachedNetworkImageProvider(newUser!.photoUrl),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: 12),
                      child: Text(
                        newUser.username,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: 12),
                      child: Text(
                        newUser.email,
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: 12),
                      child: Text(
                        newUser.about,
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            BuildButton(context, postCount, 'Posts'),
                            buildDivider(),
                            BuildButton(context, followerCount - 1, 'Followers'),
                            buildDivider(),
                            BuildButton(context, followingCount, 'Following'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            buildProfileButton(),
                          ],
                        )
                      ],
                    ),

                  ],
                ),
            );

        });
  }

  Widget BuildButton(BuildContext context, int value, String text) =>
      MaterialButton(
        padding: const EdgeInsets.all(8),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$value',
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 2,),
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold,),
            )
          ],
        ),
      );

  Widget buildDivider() => Container(
    height: 24,
    child: const VerticalDivider(color: Colors.black,),
  );

  buildProfileButton() {
    bool isProfileOwner = currentProfileId == profileId;
    if(isProfileOwner) {
      return BuildProfileButton(
        text: "Edit Profile",
        function: editUserProfile,
      );
    } else if(!isFollowing) {
      return BuildProfileButton(
          text: "Follow",
          function: handleFollowUser,
      );
    } else if(isFollowing) {
      return BuildProfileButton(
        text: "Unollow",
        function: handleUnFollowUser,
      );
    }

  }

  handleFollowUser () {
    setState(() {
      isFollowing = true;
    });
    followersRef.doc(profileId).collection('userFollowers').doc(currentProfileId).set({});

    followingRef.doc(currentProfileId).collection('userFollowing').doc(profileId).set({});

    timestamp = DateTime.now();
    activityFeedRef.doc(profileId).collection('feedItems').doc(currentProfileId).set({
      "type": "follow",
      "comment" : '',
      "mediaUrl": '',
      "postId": '',
      "username": currentUser.username,
      "userId": currentProfileId,
      "userProfileImg": currentUser.photoUrl,
      "timestamp": timestamp
    });

  }

  handleUnFollowUser () {
    setState(() {
      isFollowing = false;
    });
    followersRef.doc(profileId).collection('userFollowers').doc(currentProfileId)
      .get().then((doc) {
        if(doc.exists) {
          doc.reference.delete();
        }
    });

    followingRef.doc(currentProfileId).collection('userFollowing').doc(profileId)
      .get().then((doc) {
        if(doc.exists) {
          doc.reference.delete();
        }
    });

    timestamp = DateTime.now();
    activityFeedRef.doc(profileId).collection('feedItems').doc(currentProfileId)
      .get().then((doc) {
        if(doc.exists) {
          doc.reference.delete();
        }
    });
  }

  BuildProfileButton({required String text, required Function function}) {
    return Container(
      padding: EdgeInsets.only(top: 2),
      child: ElevatedButton(
        onPressed: () => function(),
        child: Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isFollowing ? Colors.black : Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          elevation: 1,
          backgroundColor: isFollowing ? Colors.white : CupertinoColors.activeGreen,
          shape: RoundedRectangleBorder( //to set border radius to button
              borderRadius: BorderRadius.circular(10),
            side: BorderSide(
                color: isFollowing ? Colors.grey : CupertinoColors.activeGreen
            )
          ),
        ),
      ),
    );
  }

  editUserProfile() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context)
    => editProfile(currentUserId: currentProfileId)));
  }
}
