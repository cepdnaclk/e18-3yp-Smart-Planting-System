import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:smart_planting_app/screens/home.dart';
import 'package:smart_planting_app/screens/upload.dart';
import 'package:smart_planting_app/screens/user_profile.dart';

class communityScreen extends StatefulWidget {
  const communityScreen({Key? key}) : super(key: key);

  @override
  State<communityScreen> createState() => _communityScreenState();
}

class _communityScreenState extends State<communityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const homeScreen())),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.message_outlined, color: Colors.black,)),

          IconButton(
              onPressed: () =>
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                      const profileScreen(name: '', about: '',))),
              icon: const Icon(Icons.person_pin, color: Colors.black,))
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
                    buildPost('Anushanga Pavith','asset/anushanga.jpg','asset/pic1.jpg', 2, 'Grow plants for your health'),
                    buildPost('Anushanga Pavith','asset/anushanga.jpg','asset/pic2.jpg', 2, 'Plants for future'),

                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.add_box_outlined),
                iconSize: 30,
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const upload())),
              ),
            ),
          )
        ],
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
