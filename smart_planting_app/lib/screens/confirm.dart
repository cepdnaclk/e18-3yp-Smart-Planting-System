import 'package:flutter/material.dart';

class confirmScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<confirmScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late int _code;

  Widget _buildConfirmEmailField() {
    return TextFormField(
      maxLength: 4,
      keyboardType: TextInputType.number,
      cursorHeight: 30,
      validator: (text) {
        if (text!.isEmpty) {
          return "Please enter the code";
        }
        return null;
      },
      decoration:
      const InputDecoration(
          labelText: 'Confirm Your Email',
          labelStyle: TextStyle(fontSize: 20,)),
      onSaved: (value) {
        _code = value as int;
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
                  child: _buildConfirmEmailField(),
                ),
                const SizedBox(height: 50),
                Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      minimumSize: Size(150.0, 40.0),
                      //side: BorderSide(color: Colors.yellow, width: 5),
                      textStyle: const TextStyle(
                          color: Colors.white, fontSize: 20, fontStyle: FontStyle.normal),
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      shadowColor: Colors.lightBlue,
                    ),
                    child: const Text(
                      'Confirm',
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
