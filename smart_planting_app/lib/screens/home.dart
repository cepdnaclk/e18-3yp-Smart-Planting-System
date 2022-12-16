import 'package:flutter/material.dart';
import 'package:smart_planting_app/screens/user_profile.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  List<Widget> adds = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Home', style: TextStyle(color: Colors.black)),
          centerTitle: true,
          leading: Icon(Icons.chat_outlined, color: Colors.black,),
          actions: [
            IconButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const profileScreen())),
                icon: Icon(Icons.person_pin, color: Colors.black,))
          ],
        ),
        body: Column(
          children: [
            Expanded(
              flex: 90,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Scrollbar(
                  thickness: 4,
                  radius: Radius.circular(15),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: adds,
                    ),
                  ),
                ),
              )
            ),
            Expanded(
              flex: 10,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: double.infinity,
                width: double.infinity,
                // decoration: BoxDecoration(
                //   border: Border.all(
                //     color: Colors.indigo.shade300,
                //   )
                // ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      splashColor: Colors.green,
                      child: Text(
                          'Add',
                      style: TextStyle(color: Colors.black)),
                      onPressed: () {
                        adds.add(buildPlant());
                        setState(() {});
                      },
                    ),
                    SizedBox(width: 70,),
                    FloatingActionButton(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      splashColor: Colors.green,
                      child: Text(
                          'Delete',
                          style: TextStyle(color: Colors.black)),
                      onPressed: () {
                        adds.removeLast();
                        setState(() {});
                      },
                    ),
                  ],
                ),
              )
            ),
          ],
        ),
      ),
    );
  }


  Widget buildPlant() => Padding(
    padding: EdgeInsets.symmetric(horizontal: 5),
    child: Container(
      decoration: const BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      height: 550,
      width: 320,
        child: Column(
          children: [
            const SizedBox(height: 40,),
            Image.asset('asset/plant.png', scale: 4,),
            SizedBox(height: 4,),
            const SizedBox(height: 100,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton.large(
                  elevation: 2,
                  onPressed: () {},
                  backgroundColor: Colors.green.shade200,
                  child: Image.network('https://www.iconsdb.com/icons/preview/green/sun-4-xxl.png', scale: 7),
                ),
                const SizedBox(width: 50,),
                FloatingActionButton.large(
                  elevation: 2,
                  onPressed: () {},
                  backgroundColor: Colors.green.shade200,
                  child: Image.network('https://www.iconsdb.com/icons/preview/green/temperature-2-xxl.png', scale: 8),
                ),
              ],
            ),
            const SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton.large(
                  elevation: 2,
                  onPressed: () {},
                  backgroundColor: Colors.green.shade200,
                  child: Image.network('https://www.iconsdb.com/icons/preview/green/water-9-xxl.png', scale: 8),
                ),
                const SizedBox(width: 50,),
                FloatingActionButton.large(
                  elevation: 2,
                  onPressed: () {},
                  backgroundColor: Colors.green.shade200,
                  child: Image.network('https://www.iconsdb.com/icons/preview/green/eye-3-xxl.png', scale: 6),
                ),
              ],
            ),
          ],
        ),
    ),
  );

}
