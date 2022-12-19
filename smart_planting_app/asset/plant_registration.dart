import 'package:flutter/material.dart';


class plantRegScreen extends StatefulWidget {
  const plantRegScreen({super.key});

  @override
  _plantRegScreenState createState() => _plantRegScreenState();
}

class _plantRegScreenState extends State<plantRegScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

  @override
  Widget build(BuildContext context) {
    final color = Colors.lightGreen;

    String dropDownValue = 'plant 1';
    List<String> listItem = [
      'plant 1', 'plant 2', 'plant 3', 'plant 4', 'plant 5'
    ];

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
                      'Add Plant',
                      style: TextStyle(color: Colors.black),
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
