import 'package:flutter/material.dart';
import 'package:smart_planting_app/screens/login.dart';
import 'package:smart_planting_app/screens/register.dart';

class landingScreen extends StatelessWidget {
  const landingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 450,
              color: Colors.white,
              child: Image.asset("asset/profile.png",),
            ),
            const SizedBox(height: 50,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    minimumSize: const Size(300.0, 50.0),
                    //side: BorderSide(color: Colors.yellow, width: 5),
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    shape: const StadiumBorder(side: BorderSide(color: Colors.green)),
                    shadowColor: Colors.black,
                  ),
                  child: const Text(
                    'Sign up',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => registerScreen())),
                ),
                const SizedBox(height: 20,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    minimumSize: const Size(300.0, 50.0),
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
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => loginScreen())),
                )
              ],
            )
          ],
        ),
      )
    );
  }
}
