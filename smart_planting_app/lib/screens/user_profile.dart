import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_planting_app/Storage/SecureStorageData.dart';
import 'package:smart_planting_app/screens/editProfile.dart';
import 'package:smart_planting_app/screens/profile_widget.dart';
import 'package:smart_planting_app/screens/settings.dart';
import 'package:smart_planting_app/Models/user.dart';
import 'package:smart_planting_app/screens/user_detail.dart';


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

  AppUser user = UserPreferences.myUser;

  var name;
  var about;
  var signedUserName;

  _profileScreenState(this.name, this.about);

  @override
  void initState() {
    super.initState();

    init();
  }
  Future init() async {
    final newName = await SecureStorageData.getUsername() ?? '';

    setState(() {
      signedUserName = newName;
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
    const color = Colors.lightGreen;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => editProfile())),
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
                    right: 4,
                    child: buildEditIcon(color)
                )
              ],
          ),
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

  Widget buildName(AppUser user) => Column(
    children: [
      Text(
        name == ''? signedUserName : name
        ,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
      ),
      const SizedBox(height: 4,),
      Text(
        user.email,
        style: const TextStyle(color: Colors.grey),
      )
    ],
  );

  Widget buildAbout(AppUser user) => Container(
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
            child: Image.asset('asset/profile.png', fit: BoxFit.cover, height: 140, width: 140,),
            onTap: () async {
              final source = await showImageSource(context);
              if (source == null) return;

              pickImage(source);
            }
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
    color: Colors.white,
    all: 3,
    child: buildCircle(
      color: color,
      all: 8,
      child: const Icon(
        Icons.edit,
        size: 20,
      ),
    ),
  );

  Widget buildCircle({
    required Color color,
    required double all,
    required Widget child}) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
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


