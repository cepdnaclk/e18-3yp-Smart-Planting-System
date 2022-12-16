import 'package:flutter/material.dart';
import 'package:smart_planting_app/screens/plant_page.dart';

class confirmScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<confirmScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String _code;

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
        _code = value!;
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
                      primary: Colors.white,
                      minimumSize: const Size(120.0, 40.0),
                      //side: BorderSide(color: Colors.yellow, width: 5),
                      textStyle: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      shape: const StadiumBorder(side: BorderSide(color: Colors.green)),
                      shadowColor: Colors.black,
                    ),
                    child: const Text(
                      'Confirm',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print('valid form');
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const plantScreen()));
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
