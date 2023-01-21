import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_planting_app/screens/progress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Im;
import 'package:smart_planting_app/screens/register.dart';
import 'package:smart_planting_app/screens/timeline.dart';
import 'package:uuid/uuid.dart';
import 'package:cached_network_image/cached_network_image.dart';


class upload extends StatefulWidget {
  const upload({Key? key}) : super(key: key);

  @override
  State<upload> createState() => _uploadState();
}

class _uploadState extends State<upload> {
  TextEditingController locationController = TextEditingController();
  TextEditingController captionController = TextEditingController();
  late String postCaption;
  bool isUploading = false;
  File? file;
  String postId = Uuid().v4();

  @override
  Widget build(BuildContext context) {
    return file == null ? buildSplashScreen() : buildUploadForm();
  }

  selectImage(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Create a Post'),
            children: [
              const SizedBox(height: 20,),
              SimpleDialogOption(
                padding: const EdgeInsets.only(left: 30),
                child: const Text('Camera'),
                onPressed: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.camera);
                },
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20, top: 15, right: 50, bottom: 15),
                child: Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.black,
                ),
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.only(left: 30, bottom: 20),
                child: const Text('Gallery'),
                onPressed: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.gallery);
                },
              ),
              const SizedBox(height: 10,),
              SimpleDialogOption(
                child: const Align(
                    alignment: Alignment.centerRight,
                    child: Text('Cancel')),
                onPressed: () {
                  //file != null?
                  //Navigator.of(context).push(MaterialPageRoute(builder: (context) => postWidget()));
                  Navigator.pop(context);
                }
              )
          ]
        );
      }
    );
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemp = File(image.path);
      setState(() => file = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Widget buildSplashScreen() {
    return Container(
      color: Colors.green.shade200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('asset/upload.png', height: 260,),
          const Padding(padding: EdgeInsets.only(top: 20)),
          ElevatedButton(
              onPressed: () {
                selectImage(context);
              },
              child: const Text(
                'Upload Image',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),))
        ],
      ),
    );
  }

  Widget buildUploadForm() {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black,),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const upload())),
          ),
          elevation: 0,
          backgroundColor: Colors.green,
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                ),
                onPressed: isUploading ? null : () {
                  handleSubmit();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const timelineScreen()));
                },
                child: Text(
                  'Post',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),)
            )
          ],
        ),

        body: ListView(
          children: [
            isUploading ? linearProgress() : Text(''),
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                height: 220,
                width: 250,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(file!),
                        )
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(currentUser.photoUrl),
              ),
              title: Container(
                width: 250,
                child: TextField(
                    controller: captionController,
                    onChanged: (caption) {
                      postCaption = caption;
                    },
                    decoration: InputDecoration(
                      hintText: 'add a Caption...',
                      border: InputBorder.none,
                    )
                ),
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.pin_drop, color: Colors.red, size: 35,),
              title: Container(
                width: 250,
                child: TextField(
                  controller: locationController,
                  decoration: InputDecoration(
                    hintText: 'where was the photo taken',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Container(
              width: 200,
              height: 100,
              alignment: Alignment.center,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade400,
                  shape: StadiumBorder(),
                ),
                onPressed: () => getUserLocation(),
                icon: Icon(Icons.my_location),
                label: Text("Use Current location", style: TextStyle(color: Colors.white),)),
            )
          ],
        ),
      ),
    );
  }

  getUserLocation() async {
    late Position position;

    final hasPermission = await _handleLocationPermission();
    if (hasPermission) {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high).catchError((e) {
      debugPrint(e);
    });
    }
    // Position position = await Geolocator.getCurrentPosition(
    //     desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark placemark = placemarks[0];
    String formattedAddress = "${placemark.subAdministrativeArea}, ${placemark.country}";
    locationController.text = formattedAddress;
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }


  compressImage() async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    Im.Image? imageFile = Im.decodeImage(file!.readAsBytesSync());
    final compressedImageFile = File('$path/img_$postId.jpg')..writeAsBytesSync(Im.encodeJpg(imageFile!, quality: 85));
    setState(() {
      file = compressedImageFile;
    });
  }
  
  Future<String> uploadImage(imageFile) async {
    final path = "posts/$postId.jpg";

    final ref = storageRef.child(path);
    var uploadTask = ref.putFile(imageFile);

    final snapshot = await uploadTask.whenComplete(() {});

    final downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  handleSubmit() async {
    setState(() {
      isUploading = true;
    });

    await compressImage();
    String mediaUrl = await uploadImage(file);

    creatPostInFirestore(
      mediaUrl: mediaUrl,
      location: locationController.text,
      caption: captionController.text
    );
    captionController.clear();
    locationController.clear();

    setState(() {
      isUploading = false;
      postId = Uuid().v4();

    });

  }

  Future creatPostInFirestore({required String mediaUrl, required String location, required String caption}) async {
    timestamp = DateTime.now();

    final json = {
      "postId" : postId,
      "ownerId" : currentUser.id,
      "username" : currentUser.username,
      "mediaUrl" : mediaUrl,
      "caption" : caption,
      "location" : location,
      "likes" : {},
      "timestamp" : timestamp
    };
    await postsRef.doc(currentUser.id).collection("userPosts").doc(postId).set(json);

  }

}
