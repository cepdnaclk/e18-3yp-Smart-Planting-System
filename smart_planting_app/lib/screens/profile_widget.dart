import 'dart:html';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileWidget extends StatelessWidget {
  const profileWidget({Key? key}) : super(key: key);

  final File image;
  final ValueChanged<ImageSource> onClicked;

  const ProfileWidget (
  {
    Key? key,
    required this.image,
    required this.onClicked,
  }) : super(key: key);

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
              child: buildEdition(color)
          )
        ],
      ),
    );
  }
  
  Widget buildImage(BuildContext context) {
    final imagePath = this.image,path;
    final Object image;
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

 Widget buildEdition(Color color) {

 }

}
