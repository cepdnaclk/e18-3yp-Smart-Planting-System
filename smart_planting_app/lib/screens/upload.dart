import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class upload extends StatefulWidget {
  const upload({Key? key}) : super(key: key);

  @override
  State<upload> createState() => _uploadState();
}

class _uploadState extends State<upload> {
  File? file;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).accentColor.withOpacity(0.6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('asset/upload.png', height: 260,),
          const Padding(padding: EdgeInsets.only(top: 20)),
          ElevatedButton(
              onPressed: () => selectImage(context),
              child: const Text('Upload Image', style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),))
        ],
      ),
    );
  }

  selectImage(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Create a Post'),
            children: [
              SizedBox(height: 20,),
              SimpleDialogOption(
                padding: EdgeInsets.only(left: 30),
                child: const Text('Camera'),
                onPressed: () {
                  pickImage(ImageSource.camera);
                },
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, top: 15, right: 50, bottom: 15),
                child: Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.black,
                ),
              ),
              SimpleDialogOption(
                padding: EdgeInsets.only(left: 30, bottom: 20),
                child: const Text('Gallery'),
                onPressed: () {
                  pickImage(ImageSource.gallery);
                },
              ),
              SizedBox(height: 10,),
              SimpleDialogOption(
                child: Align(
                    alignment: Alignment.centerRight,
                    child: const Text('Cancel')),
                onPressed: () => Navigator.pop(context),
              )
            ],
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
}
