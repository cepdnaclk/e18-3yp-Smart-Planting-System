import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_planting_app/screens/profile_widget.dart';
import 'package:smart_planting_app/screens/user.dart';
import 'package:smart_planting_app/screens/user_detail.dart';

class profileScreen extends StatefulWidget {
  const profileScreen({Key? key}) : super(key: key);

  @override
  State<profileScreen> createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen> {
  late File image = File('asset/profile.png');

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

  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert_rounded, color: Colors.black),
          )
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            image: image,
            onClicked: (source) => pickImage(source),
            //imagePath: user.imagePath,
          ),
          const SizedBox(height: 20,),
          buildName(user),
          const SizedBox(height: 20,),
          const StatWidget(),
          const SizedBox(height: 20,),
          buildAbout(user),
        ],
      ),
    );
  }

  Widget buildName(User user) => Column(
    children: [
      Text(
        user.name,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
      ),
      const SizedBox(height: 4,),
      Text(
        user.email,
        style: const TextStyle(color: Colors.grey),
      )
    ],
  );

  Widget buildAbout(User user) => Container(
    padding: const EdgeInsets.all(30),
    child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'About',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2,),
          Text(
            user.about,
            style: const TextStyle(),
          )

        ],
      ),
  );
}

class StatWidget extends StatelessWidget {
  const StatWidget({super.key});

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      BuildButton(context, '9.9', 'Ranking'),
      buildDivider(),
      BuildButton(context, '45', 'Following'),
      buildDivider(),
      BuildButton(context, '5', 'Followers'),
    ],
  );


  Widget BuildButton(BuildContext context, String value, String text) =>
      MaterialButton(
        padding: const EdgeInsets.all(8),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              value,
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


