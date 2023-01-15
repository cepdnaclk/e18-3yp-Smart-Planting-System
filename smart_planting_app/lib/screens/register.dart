import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smart_planting_app/screens/configs/register_config.dart';
import 'package:smart_planting_app/screens/user.dart';
import 'package:uuid/uuid.dart';
import 'profile_widget.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as Im;
import 'package:http/http.dart' as http;
import 'dart:convert' as cnv;

late String name;
late String email;
late String password;
late String confirmPwd ;
late int mobile;
final Reference storageRef = FirebaseStorage.instance.ref();
final usersRef = FirebaseFirestore.instance.collection('users');
final postsRef = FirebaseFirestore.instance.collection('posts');
final commentRef = FirebaseFirestore.instance.collection('comments');
final activityFeedRef = FirebaseFirestore.instance.collection('feed');
final followersRef = FirebaseFirestore.instance.collection('followers');
final followingRef = FirebaseFirestore.instance.collection('following');
final timelineRef = FirebaseFirestore.instance.collection('timeline');
AppUser currentUser = AppUser(
    id: 'id', username: 'username', email: 'email', password: 'password', photoUrl: 'photoUrl', about: 'about');
DateTime timestamp = DateTime.now();


class registerScreen extends StatefulWidget {
  const registerScreen({super.key});

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<registerScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final controller = Get.put(SignUpController());
  String userId = Uuid().v4();

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

  Widget _buildNameField() {
    return TextFormField(
      controller: controller.fullName,
      validator: (text) {
        return HelperValidator.nameValidate(text!);
      },
      maxLength: 50,
      maxLines: 1,
      decoration:
      const InputDecoration(labelText: 'Name', hintText: 'Enter your full name', ),
      onChanged: (value) {
        name = value;
      },
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: controller.email,
      maxLength: 50,
      validator: (text) {
        if (text!.isEmpty) {
          return "Please enter a valid email";
        }
        return null;
      },
      decoration:
      const InputDecoration(labelText: 'Email', hintText: 'example@gmail.com'),
      onChanged: (value) {
        email = value;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: controller.password,
      obscureText: true,
      maxLength: 10,
      validator: (text) {
        if (text!.isEmpty) {
          return "Please enter a password";
        }
        return null;
      },
      decoration: const InputDecoration(
          labelText: 'Password', hintText: 'Enter your password'),
      onChanged: (value) {
        confirmPwd = value;
      },
      // onSaved: (value) {
      //   _password = value!;
      // },
    );
  }

  Widget _buildConfirmPasswordField() {
    return TextFormField(
      obscureText: true,
      maxLength: 10,
      validator: (text) {
        if (text!.isEmpty) {
          return "Please enter a password";
        }
        else if (text != confirmPwd) {
          return "Password is incorrect";
        }
        return null;
      },
      decoration: const InputDecoration(
          labelText: 'Confirm Password', hintText: 'Re-type your password'),
      onChanged: (value) {
        password = value;
      },
    );
  }

  Widget _buildMobileNumberField() {
    return TextFormField(
      controller: controller.mobileNo,
      maxLength: 10,
      keyboardType: TextInputType.number,
      validator: (text) {
        if (text!.isEmpty) {
          return "Please enter a mobile Number";
        }
        return null;
      },
      decoration: const InputDecoration(
          labelText: 'Mobile Number', hintText: 'Enter a mobile number'),
      onChanged: (value) {
        mobile = int.parse(value);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = Colors.black38;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 50,),
                if (image != null)
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
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: _buildNameField(),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: _buildEmailField(),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: _buildPasswordField(),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: _buildConfirmPasswordField(),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: _buildMobileNumberField(),
                ),
                const SizedBox(height: 50),
                Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      minimumSize: const Size(120.0, 40.0),
                      //side: BorderSide(color: Colors.yellow, width: 5),
                      textStyle: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      shape: const StadiumBorder(side: BorderSide(color: Colors.green)),
                      shadowColor: Colors.black,
                    ),
                    child: const Text(
                      'Sign up',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        createUserInFirestore();
                        print('valid form');
                        SignUpController.instance.registerUser(controller.fullName.text.trim(), controller.email.text.trim(), controller.password.text.trim(), controller.mobileNo.text.trim());
                        _formKey.currentState!.save();
                        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => confirmScreen()));
                      } else {
                        print('not valid form');
                        return;
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }

  compressImage() async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    Im.Image? imageFile = Im.decodeImage(image!.readAsBytesSync());
    final compressedImageFile = File('$path/img_$userId.jpg')..writeAsBytesSync(Im.encodeJpg(imageFile!, quality: 85));
    setState(() {
      image = compressedImageFile;
    });
  }

  Future<String> uploadImage(imageFile) async {
    final path = "profileImages/$userId.jpg";

    final ref = storageRef.child(path);
    var uploadTask = ref.putFile(imageFile);

    final snapshot = await uploadTask.whenComplete(() {});

    final downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }


  createUserInFirestore() async {
    await compressImage();
    String photoUrl = await uploadImage(image);

    await usersRef.doc(userId).set({
    "userId": userId,
    "username": name,
    "email" : email,
    "password" : password,
    "photoUrl" : photoUrl,
    "mobileNo" : mobile,
    "about" : ""
    });

    currentUser = AppUser(id: userId, username: name, email: email, password: password, photoUrl: photoUrl, about: '');

  }

  Widget buildImage() {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            child: Image.asset('asset/profile.png', height: 100, width: 100,),
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
      all: 8,
      child: const Icon(
        color: Colors.white30,
        Icons.camera_alt_outlined,
        size: 25,
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

class HelperValidator {
  static String? nameValidate(String value) {
    if (value.isEmpty) {
      return "Name can't be empty";
    }
    if (value.length < 2) {
      return "Name must be at least 2 characters long";
    }
    if (value.length > 50) {
      return "Name must be less than 50 characters long";
    }
    return null;
  }
}
