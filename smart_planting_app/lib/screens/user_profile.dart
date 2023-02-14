import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_planting_app/screens/editProfile.dart';
import 'package:smart_planting_app/screens/home.dart';
import 'package:smart_planting_app/screens/post_tile.dart';
import 'package:smart_planting_app/screens/posts.dart';
import 'package:smart_planting_app/screens/profile_widget.dart';
import 'package:smart_planting_app/screens/progress.dart';
import 'package:smart_planting_app/screens/register.dart';
import 'package:smart_planting_app/screens/settings.dart';
import 'package:smart_planting_app/Models/user.dart';
import 'package:smart_planting_app/screens/user_detail.dart';

late bool isLoading;
late int postCount;

class profileScreen extends StatefulWidget {
  final String name;
  final String about;

  const profileScreen(
      {Key? key,
      required this.name,
      required this.about,
      }) : super(key: key);

  @override
  State<profileScreen> createState() => _profileScreenState(name, about);
}

class _profileScreenState extends State<profileScreen> {
  File? image;
  var name;
  var about;
  String postOrientation = 'grid';

  List<posts> postsList = [];

  AppUser user = UserPreferences.myUser;

  _profileScreenState(this.name, this.about);



  @override
  void initState() {
    super.initState();
    getProfilePost();
  }

  getProfilePost() async {
    setState(() {
      isLoading = true;
    });
    QuerySnapshot snapshot = await postsRef.doc(currentUser.id).collection('userPosts').get();

    setState(() {
      isLoading = false;
      postCount = snapshot.docs.length;
      postsList = snapshot.docs.map((doc) => posts.fromDocument(doc)).toList();
    });
  }


  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<ImageSource?> showImageSource(BuildContext context) async {
    if(Platform.isIOS) {
      return showCupertinoModalPopup<ImageSource>(
          context: context,
          builder: (context) => CupertinoActionSheet(
            actions: [
              CupertinoActionSheetAction(
                  onPressed: () => Navigator.of(context).pop(ImageSource.camera),
                  child: const Text('Camera')
              ),
              CupertinoActionSheetAction(
                onPressed: () => Navigator.of(context).pop(ImageSource.gallery),
                child: const Text('Gallery'),
              )
            ],
          )
      );
    }
    else {
      return showModalBottomSheet(
          context: context,
          builder: (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () => Navigator.of(context).pop(ImageSource.camera),
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Gallery'),
                onTap: () => Navigator.of(context).pop(ImageSource.gallery),
              )
            ],
          )
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const homeScreen())),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => editProfile(currentUserId: currentUser.id,))),
            icon: const Icon(Icons.edit, color: Colors.black),
          ),
          IconButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const settingScreen())),
              icon: const Icon(Icons.more_vert_rounded, color: Colors.black),
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          if (image != null)
            ProfileWidget(
              image: image,
              onClicked: (source) => pickImage(source),
            )
            else Center(
              child: Stack(
              children: [
                buildImage(),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: buildEditIcon()
                )
              ],
          ),
            ),
          const SizedBox(height: 20,),
          buildName(user),
          buildAbout(user),
          const SizedBox(height: 15,),
          StatWidget(),
          const SizedBox(height: 15,),
          const Divider(),
          buildTogglePostOrientation(),
          const Divider(),
          buildProfilePost(),

        ],
      ),
    );
  }

  Widget buildName(AppUser user) => Column(
    children: [
      Text(
        currentUser.username
        ,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
      ),
      const SizedBox(height: 3,),
      Text(
        currentUser.email,
        style: const TextStyle(color: Colors.grey),
      )
    ],
  );

  Widget buildAbout(AppUser user) => Container(
    padding: const EdgeInsets.all(6),
    child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
              about == ''? user.about : about,
            style: const TextStyle(),
          )

        ],
      ),
  );

  Widget buildImage() {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            child: Image.network(currentUser.photoUrl, fit: BoxFit.cover, height: 95, width: 95,),
            onTap: () async {
              final source = await showImageSource(context);
              if (source == null) return;

              pickImage(source);
            }
        ),
      ),
    );
  }

  Widget buildEditIcon() => buildCircle(
    all: 2,
    child: buildCircle(
      all: 0,
      child: const Icon(
        color: Colors.black38,
        Icons.camera_alt_outlined,
        size: 25,
      ),
    ),
  );

  Widget buildCircle({
    required double all,
    required Widget child}) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: Colors.transparent,
          child: child,
        ),
      );

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
}

class StatWidget extends StatelessWidget {
  StatWidget({super.key,});

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      BuildButton(context, postCount, 'Posts'),
      buildDivider(),
      BuildButton(context, 0, 'Following'),
      buildDivider(),
      BuildButton(context, 0, 'Followers'),
    ],
  );


  Widget BuildButton(BuildContext context, int value, String text) =>
      MaterialButton(
        padding: const EdgeInsets.all(8),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '$value',
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 2,),
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      );

  Widget buildDivider() => Container(
    height: 24,
    child: const VerticalDivider(color: Colors.black,),
  );

}


