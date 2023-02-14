import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:smart_planting_app/screens/activityFeed.dart';
import 'package:smart_planting_app/screens/chat_pages/group_page.dart';
import 'package:smart_planting_app/screens/home.dart';
import 'package:smart_planting_app/screens/progress.dart';
import 'package:smart_planting_app/screens/register.dart';
import 'package:smart_planting_app/screens/search.dart';
import 'package:smart_planting_app/screens/upload.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:smart_planting_app/screens/user_profile.dart';

final usersRef = FirebaseFirestore.instance.collection('Users_Collection');

class communityScreen extends StatefulWidget {
  const communityScreen({Key? key}) : super(key: key);

  @override
  State<communityScreen> createState() => _communityScreenState();
}

class _communityScreenState extends State<communityScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 10,
          backgroundColor: Colors.green,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
            color: Colors.black,
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const homeScreen())),
          ),
          actions: [
            IconButton(
                icon: const Icon(Icons.search, color: Colors.black,),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const searchScreen())),
            ),
            IconButton(
              icon: const Icon(Icons.notifications_active_outlined, color: Colors.black,),
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const activityFeed())),
            ),
            IconButton(
                onPressed: () =>
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                        const GroupPage())),
                icon: const Icon(Icons.message_outlined, color: Colors.black,))
          ],
        ),
        body: Column(
          children: [
            Expanded(
              flex: 90,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                height: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    children: [
                      // ListView(
                      //   children: users.map((user) => Text(user['postCount'])).toList(),
                      // ),
                      // StreamBuilder<QuerySnapshot>(
                      //     stream: usersRef.snapshots(),
                      //     builder: (context, snapShot) {
                      //       if(!snapShot.hasData){
                      //         return circularProgress();
                      //       }
                      //       Iterable children = snapShot.data!.docs.map(
                      //               (doc) => doc['userName']);
                      //       print(children);
                      //       return ListView(
                      //         children: [
                      //           Text(children.iterator.toString())
                      //         ],
                      //       );
                      //     }),
                      buildPost(
                          'Anushanga Pavith',
                          'asset/anushanga.jpg',
                          'asset/pic1.jpg',
                          2,
                          'Grow plants for your health'),
                      buildPost('Anushanga Pavith','asset/anushanga.jpg','asset/pic2.jpg', 2, 'Plants for future'),

                    ],
                  ),
                ),
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
                      icon: const Icon(Icons.add_box_outlined),
                      iconSize: 30,
                      onPressed: () =>
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const upload())),
                    ),
                    IconButton(
                      icon: CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(currentUser.photoUrl),
                      ),
                      color: CupertinoColors.activeGreen,
                      iconSize: 30,
                      onPressed: () =>
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                          profileScreen(about: '',name: '',))),
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

 Widget buildPost(String name, String userImage, String postImage, int likes, String caption) {
    return Column(
      children: [
        ListTile(
          leading: Container(
            height: 40,
            width: 40,
            child: ClipOval(
              child: Image.asset(userImage, fit: BoxFit.cover,),
            ),
          ),
          title: Container(
            width: 250,
            child: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),),
          ),
        ),
        Image.asset(postImage),
        Padding(
          padding: const EdgeInsets.only(top: 5, left: 5,),
          child: Row(
            children: [
              LikeButton(
                padding: const EdgeInsets.only(right: 7),
                size: 30,
                likeCount: likes,
              ),
              const Text('Likes', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
              IconButton(onPressed: () {}, icon: Icon(Icons.mode_comment,)),
              SizedBox(width: 155,),
              IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_rounded,))
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 5, left: 5, right: 5),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              caption, style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w400),
            ),
          ),
        ),
        const SizedBox(height: 20,),
        Divider(
          color: Colors.grey.shade400,
          endIndent: 100,
          indent: 100,
        )
      ],
    );
 }
}
