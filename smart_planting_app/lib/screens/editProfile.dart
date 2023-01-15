import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smart_planting_app/screens/chat_pages/login_page.dart';
import 'package:smart_planting_app/screens/profile_widget.dart';
import 'package:smart_planting_app/screens/progress.dart';
import 'package:smart_planting_app/screens/register.dart';
import 'package:smart_planting_app/screens/user.dart';
import 'package:image/image.dart' as Im;
import 'package:smart_planting_app/service/auth_service.dart';

import '../AuthRepository/authRepo.dart';


class editProfile extends StatefulWidget {
  final String currentUserId;

  const editProfile({Key? key, required this.currentUserId}) : super(key: key);

  @override
  State<editProfile> createState() => _editProfileState(currentUserId: currentUserId);
}

class _editProfileState extends State<editProfile> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  bool isLoading = false;
  late AppUser user;
  final String currentUserId;
  String userName = currentUser.username;
  String photoUrl = currentUser.photoUrl;
  bool _usernameValid = true;
  bool _bioValid = true;
  AuthService authService = AuthService();

  _editProfileState({Key? key, required this.currentUserId});

  @override
  void initState() {
    super.initState();
    getUser();
  }

  getUser() async {
    setState(() {
      isLoading = true;
    });

    DocumentSnapshot doc = await usersRef.doc(currentUserId).get();

    user = AppUser.fromDocument(doc);
    usernameController.text = user.username;
    aboutController.text = user.about;

    setState(() {
      isLoading = false;
    });
  }

  File? image;

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

  compressImage() async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    Im.Image? imageFile = Im.decodeImage(image!.readAsBytesSync());
    final compressedImageFile = File('$path/img_$currentUserId.jpg')..writeAsBytesSync(Im.encodeJpg(imageFile!, quality: 85));
    setState(() {
      image = compressedImageFile;
    });
  }

  Future<String> uploadImage(imageFile) async {
    final path = "profileImages/$currentUserId.jpg";

    final ref = storageRef.child(path);
    var uploadTask = ref.putFile(imageFile);

    final snapshot = await uploadTask.whenComplete(() {});

    final downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }



  @override
  Widget build(BuildContext context) {
    final color = Colors.transparent;
    return Scaffold(
      key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Edit Profile", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
            backgroundColor: Colors.green,
          actions: [
            IconButton(
              icon: const Icon(Icons.done, color: Colors.white, size: 30,),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      body: isLoading ? circularProgress()
            : ListView(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(height: 16,),
                if(image != null)
                  ProfileWidget(
                    image: image,
                    onClicked: (source) => pickImage(source),
                  )
                else Stack(
                  children: [
                    buildImage(),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: buildEditIcon(color)
                    )
                  ],
                ),
                SizedBox(height: 10,),
                Padding(padding: EdgeInsets.only(top: 16),
                  child: buildUserNameField(),
                ),
                Padding(padding: EdgeInsets.only(top: 16),
                  child: buildAboutField(),
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                    onPressed: updateProfileData,
                    child: Text('Update Profile'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CupertinoColors.activeGreen,
                      elevation: 1,
                      shape: RoundedRectangleBorder( //to set border radius to button
                          borderRadius: BorderRadius.circular(10),
                      )
                    ),
                ),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                    ),
                    onPressed: () => logOut(),
                    icon: Icon(Icons.cancel, color: Colors.red,),
                    label: Text('Logout', style: TextStyle(color: Colors.red),
                    )
                ),

              ],
            ),
          )
        ],
      ),
    );
  }


  Widget buildImage() {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            child: Image.network(user.photoUrl, fit: BoxFit.cover, height: 95, width: 95,),
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
    color: Colors.transparent,
    all: 0,
    child: buildCircle(
      color: color,
      all: 0,
      child: const Icon(
        color: Colors.black38,
        Icons.camera_alt_outlined,
        size: 25,
      ),
    ),
  );

  Widget buildCircle({required Color color, required double all, required Widget child}) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );

  Column buildUserNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(top: 12),
          child: Text('Username', style: TextStyle(color: Colors.grey),),
        ),
        TextField(
          onChanged: (name) {
            userName = name;
          },
          controller: usernameController,
          decoration: InputDecoration(
            hintText: 'New Username',
            errorText: _usernameValid ? null : "Username too short"
          ),
        )
      ],
    );
  }

  Column buildAboutField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 12),
          child: Text('Bio', style: TextStyle(color: Colors.grey),),
        ),
        TextField(
          controller: aboutController,
          decoration: InputDecoration(
            hintText: 'Edit Bio',
              errorText: _bioValid ? null : "Nio"
          ),
        )
      ],
    );
  }


  updateProfileData() async {
    usernameController.text.trim().length < 3 ||
    usernameController.text.isEmpty ? _usernameValid = false :
        _usernameValid = true;
    aboutController.text.trim().length > 100 ? _bioValid = false :
        _bioValid = true;

    if(_usernameValid && _bioValid) {
      await compressImage();
      photoUrl = await uploadImage(image);

      usersRef.doc(currentUserId).update({
        "username" : userName,
        "about" : aboutController.text,
        "photoUrl" : photoUrl,
      });
      currentUser = AppUser(
          id: currentUser.id,
          username: userName,
          email: currentUser.email,
          password: currentUser.password,
          photoUrl: photoUrl,
          about: aboutController.text);

      const snackbar = SnackBar(content: Text('Profile updated!'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  logOut() async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Logout"),
            content: const Text("Are you sure you want to logout?"),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
              ),
              IconButton(
                onPressed: () async {
                  await authService.signOut();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                          (route) => false);
                },
                icon: const Icon(
                  Icons.done,
                  color: Colors.green,
                ),
              ),
            ],
          );
        });
  }


}
