import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'configs/login_config.dart';

class loginScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<loginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final controller = Get.put(LogInController());

  late String _email;
  late String _password;

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
      onSaved: (value) {
        _email = value!;
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
      onSaved: (value) {
        _password = value!;
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: 750,
          alignment: Alignment.center,
          margin: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 50,),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: _buildEmailField(),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: _buildPasswordField(),
                ),
                const SizedBox(height: 50),
                ElevatedButton(
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
                      'Login',
                      style: TextStyle(color: Colors.black),
                    ),
                  onPressed: () {
                    if(_formKey.currentState!.validate()) {
                      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const homeScreen()));
                      LogInController.instance.logInUser(controller.email.text.trim(), controller.password.text.trim());
                      _formKey.currentState!.save();
                    } else {
                      print('Not a valid form');
                    }
                    return;
                  }
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
