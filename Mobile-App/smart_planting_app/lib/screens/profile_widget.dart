import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileWidget extends StatelessWidget {
  final File image;
  final ValueChanged<ImageSource> onClicked;

  const ProfileWidget({Key? key, required this.image, required this.onClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Center(
      child: Stack(
        children: [
          buildImage(context),
          Positioned(
              bottom: 0,
              right: 4,
              child: buildEditIcon(color)
          )
        ],
      ),
    );
  }
  
  Widget buildImage(BuildContext context) {
    final imagePath = this.image.path;
    final image;
    if (imagePath.contains('https://')) {
      image = NetworkImage(imagePath);
    } else {
      image = FileImage(File(imagePath));
    }
    
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image as ImageProvider,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(
              onTap: () async {
                final source = await showImageSource(context);
                if (source == null) return;
              }
          ),
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

  Future<Future> showImageSource(BuildContext context) async {
    if(Platform.isIOS) {
      return showCupertinoModalPopup(
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
