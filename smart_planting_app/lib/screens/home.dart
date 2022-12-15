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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('Home', style: TextStyle(color: Colors.black),),
        centerTitle: true,
        leading: const Icon(Icons.chat_outlined, color: Colors.black,),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const profileScreen())),
              icon: const Icon(Icons.person_pin, color: Colors.black,))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 90,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Scrollbar(
                thickness: 4,
                radius: const Radius.circular(15),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
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
              padding: const EdgeInsets.symmetric(horizontal: 15),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    splashColor: Colors.green,
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    child: const Text(
                        'Add',
                    style: TextStyle(color: Colors.black)),
                    onPressed: () {
                      adds.add(buildPlant());
                      setState(() {});
                    },
                  ),
                  const SizedBox(width: 80,),
                  FloatingActionButton(
                    focusColor: Colors.green,
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    child: const Text(
                        'Delete',
                        style: TextStyle(color: Colors.black)),
                    onPressed: () {
                      adds.removeLast();
                      setState(() {});
                    }
                  )
                ],
              ),
            )
          ),
        ],
      ),
    );
  }


  Widget buildPlant() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5),
    child: Container(
      decoration: const BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      height: 550,
      width: 320,
        child: Column(
          children: [
            const SizedBox(height: 40,),
            Image.asset('asset/plant.png', scale: 4,),
            const SizedBox(height: 8,),
            const SizedBox(height: 100,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton.large(
                  elevation: 3,
                  backgroundColor: Colors.green.shade200,
                  onPressed: () {},
                  child: Image.network('https://www.iconsdb.com/icons/preview/green/sun-4-xxl.png', scale: 5),
                ),
                const SizedBox(width: 50,),
                FloatingActionButton.large(
                  elevation: 3,
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
                  elevation: 3,
                  onPressed: () {},
                  backgroundColor: Colors.green.shade200,
                  child: Image.network('https://www.iconsdb.com/icons/preview/green/water-9-xxl.png', scale: 8),
                ),
                const SizedBox(width: 50,),
                FloatingActionButton.large(
                  elevation: 3,
                  onPressed: () {},
                  backgroundColor: Colors.green.shade200,
                  child: Image.network('https://www.iconsdb.com/icons/preview/green/eye-3-xxl.png', scale: 8),
                ),
              ],
            ),
          ],
        ),
    ),
  );

}
