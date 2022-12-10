import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'profile_widget.dart';

class registerScreen extends StatefulWidget {
  const registerScreen({super.key});

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<registerScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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

  late String _name;
  late String _email;
  late String _password;
  late String _confirmPwd;
  late int _mobile;

  Widget _buildNameField() {
    return TextFormField(
      validator: (text) {
        return HelperValidator.nameValidate(text!);
      },
      maxLength: 50,
      maxLines: 1,
      decoration:
      const InputDecoration(labelText: 'Name', hintText: 'Enter your full name', ),
      onSaved: (value) {
        _name = value!;
      },
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      maxLength: 50,
      validator: (text) {
        if (text!.isEmpty) {
          return "Please enter a valid email";
        }
        return null;
      },
      decoration:
      const InputDecoration(labelText: 'Email', hintText: 'example@gmail.com'),
      onSaved: (value) {
        _email = value!;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
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
        _confirmPwd = value;
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
        else if (text != _confirmPwd) {
          return "Password is incorrect";
        }
        return null;
      },
      decoration: const InputDecoration(
          labelText: 'Confirm Password', hintText: 'Re-type your password'),
      onSaved: (value) {
        _password = value!;
      },
    );
  }

  Widget _buildMobileNumberField() {
    return TextFormField(
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
      onSaved: (value) {
        _mobile = int.parse(value!);
      },
    );
  }

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          //color: Colors.white,
          margin: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 50,),
                if (image != null)
                  ProfileWidget(
                        image: image!,
                        onClicked: (source) => pickImage(source)
                    )
                else ClipOval(
                  child: Material(
                    color: Colors.transparent,
                    child: Ink.image(
                        image: const NetworkImage(
                          'https://as2.ftcdn.net/v2/jpg/02/39/27/77/1000_F_239277786_ECErblLv6fA7Rx7SUvzso9MQyhWOg8ik.jpg'
                        ),
                      fit: BoxFit.cover,
                      height: 130,
                      width: 130,
                      child: InkWell(
                        onTap: () async {
                          final source = await showImageSource(context);
                          if (source == null) return;
                        },
                      ),
                    ),
                  ),
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
                      primary: Colors.black,
                      minimumSize: const Size(150.0, 40.0),
                      //side: BorderSide(color: Colors.yellow, width: 5),
                      textStyle: const TextStyle(
                          color: Colors.white, fontSize: 20, fontStyle: FontStyle.normal),
                      shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      shadowColor: Colors.lightBlue,
                    ),
                    child: const Text(
                      'Register',
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print('valid form');
                        _formKey.currentState!.save();
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
