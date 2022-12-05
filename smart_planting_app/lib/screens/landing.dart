import 'package:flutter/material.dart';
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
              child: Image.asset("asset/icon1.png", cacheHeight: 100,),
            ),
            const SizedBox(height: 80,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: Text('Sign In'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    minimumSize: Size(300.0, 50.0),
                    //side: BorderSide(color: Colors.yellow, width: 5),
                    textStyle: const TextStyle(
                        color: Colors.white, fontSize: 25, fontStyle: FontStyle.normal),
                    shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    shadowColor: Colors.lightBlue,
                  ),
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const registerScreen())),
                ),
                const SizedBox(height: 20,),
                ElevatedButton(
                  child: Text('Login In'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    minimumSize: Size(300.0, 50.0),
                    //side: BorderSide(color: Colors.yellow, width: 5),
                    textStyle: const TextStyle(
                        color: Colors.white, fontSize: 25, fontStyle: FontStyle.normal),
                    shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    shadowColor: Colors.lightBlue,
                    ),
                  onPressed: () {},
                )
              ],
            )
          ],
        ),
      )
    );
  }
}
