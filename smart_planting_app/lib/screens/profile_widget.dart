import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileWidget extends StatelessWidget {
  final File? image;
  final ValueChanged<ImageSource> onClicked;

  const ProfileWidget(
      {Key? key,
        required this.image,
        required this.onClicked,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Colors.black26;

    return Center(
      child: Stack(
        children: [
          buildImage(context),
          Positioned(
              bottom: 0,
              right: 0,
              child: buildEditIcon(color)
          )
        ],
      ),
    );
  }

  Widget buildImage(BuildContext context) {
    final String imagePath;
    final Object image;

    imagePath = this.image!.path;

    if (imagePath.contains('https://')) {
      image = NetworkImage(imagePath);
    } else {
      image = FileImage(File(imagePath));
    }

    return ClipOval(
      child: Material(
        shape: const CircleBorder(side: BorderSide(color: Colors.black)),
        color: Colors.transparent,
        child: Ink.image(
          image: image as ImageProvider,
          fit: BoxFit.cover,
          width: 90,
          height: 90,
          child: InkWell(
            onTap: () async {
              final source = await showImageSource(context);
              if (source == null) return;

              onClicked(source);
            }
          ),
        ),
      ),
    );
  }

 Widget buildEditIcon(Color color) => buildCircle(
   color: Colors.transparent,
   all: 0,
   child: buildCircle(
     color: color,
     all: 5,
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

}
