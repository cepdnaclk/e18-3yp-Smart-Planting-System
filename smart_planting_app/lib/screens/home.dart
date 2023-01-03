import 'package:flutter/material.dart';
import 'package:smart_planting_app/screens/Plant_reg_page.dart';
import 'package:smart_planting_app/screens/community.dart';
import 'package:smart_planting_app/screens/user_profile.dart';

List<Widget> adds = [];

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Home', style: TextStyle(color: Colors.black)),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.chat_outlined),
            color: Colors.black,
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const communityScreen())),
          ),
          actions: [
            IconButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const profileScreen(name: '', about: '',))),
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
                      child: const Text(
                          'Add',
                      style: TextStyle(color: Colors.black)),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const plantRegScreen()));
                        // adds.add(buildPlant());
                        setState(() {});
                      },
                    ),
                    const SizedBox(width: 70,),
                    FloatingActionButton(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      splashColor: Colors.green,
                      child: const Text(
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


  // Widget buildPlant() => Padding(
  //   padding: const EdgeInsets.symmetric(horizontal: 5),
  //   child: Container(
  //     decoration: const BoxDecoration(
  //         color: Colors.black26,
  //         borderRadius: BorderRadius.all(Radius.circular(20))
  //     ),
  //     height: 550,
  //     width: 320,
  //       child: Column(
  //         children: [
  //           const SizedBox(height: 40,),
  //           Image.asset('asset/plant.png', scale: 4,),
  //           const SizedBox(height: 4,),
  //           const SizedBox(height: 100,),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               FloatingActionButton.large(
  //                 elevation: 2,
  //                 onPressed: () {},
  //                 backgroundColor: Colors.green.shade200,
  //                 child: Image.network('https://www.iconsdb.com/icons/preview/green/sun-4-xxl.png', scale: 7),
  //               ),
  //               const SizedBox(width: 50,),
  //               FloatingActionButton.large(
  //                 elevation: 2,
  //                 onPressed: () {},
  //                 backgroundColor: Colors.green.shade200,
  //                 child: Image.network('https://www.iconsdb.com/icons/preview/green/temperature-2-xxl.png', scale: 8),
  //               ),
  //             ],
  //           ),
  //           const SizedBox(height: 50,),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               FloatingActionButton.large(
  //                 elevation: 2,
  //                 onPressed: () {},
  //                 backgroundColor: Colors.green.shade200,
  //                 child: Image.network('https://www.iconsdb.com/icons/preview/green/water-9-xxl.png', scale: 8),
  //               ),
  //               const SizedBox(width: 50,),
  //               FloatingActionButton.large(
  //                 elevation: 2,
  //                 onPressed: () {},
  //                 backgroundColor: Colors.green.shade200,
  //                 child: Image.network('https://www.iconsdb.com/icons/preview/green/eye-3-xxl.png', scale: 6),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //   ),
  // );

}

class addPlant {
  //Plant p1 = new Plant(plantType: plantType, plantID: plantID, scientificName: scientificName, about: about);

  addPlant(BuildContext context,String plantName) {
    adds.add(buildPlant(context, plantName));
  }

  Future popUpWindow(BuildContext context, String title, double currentData, double requiredData) => showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 2,
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(
                color: Colors.green,
              )
          ),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 12,),
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                ),
                const SizedBox(height: 12,),
                Text(
                  'Current Level   : $currentData',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 4,),
                Text(
                  'Required Level : $requiredData',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 12,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade600
                  ),
                  child: const Text('Balance'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )

              ],
            ),
          ),
        );
      }
  );

  Widget buildPlant(BuildContext context,String plantType) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5),
    child: Container(
      decoration: const BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      height: 550,
      width: 320,
      child: Column(
        children: [
          const SizedBox(height: 20,),
          Image.asset('asset/plan2.png', scale: 7,),
          const SizedBox(height: 8,),
          Text(plantType, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black), ),
          const SizedBox(height: 4,),
          const SizedBox(height: 50,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 100,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 2,
                      backgroundColor: Colors.green.shade200,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                            color: Colors.black,
                          )
                      )
                  ),
                  child: Image.asset('asset/light.png', scale: 7),
                  onPressed: () {
                    popUpWindow(context, 'Light Intensity', 103.4, 150);
                  },
                ),
              ),
              const SizedBox(width: 50,),
              Container(
                height: 100,
                width: 100,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 2,
                      backgroundColor: Colors.green.shade200,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                            color: Colors.black,
                          )
                      )
                  ),
                  child: Image.asset('asset/temp.png', scale: 8),
                  onPressed: () {
                    popUpWindow(context, 'Temperature', 25.8, 27);
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 25,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 100,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 2,
                      backgroundColor: Colors.green.shade200,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                            color: Colors.black,
                          )
                      )
                  ),
                  child: Image.asset('asset/waterlevel.png', scale: 8),
                  onPressed: () {
                    popUpWindow(context, 'Water Level', 3, 8);
                  },
                ),
              ),

              const SizedBox(width: 50,),
              Container(
                height: 100,
                width: 100,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 2,
                    backgroundColor: Colors.green.shade200,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(
                        color: Colors.black,
                      )
                    )
                  ),
                  child: Image.asset('asset/soil.png', scale: 6),
                  onPressed: () {
                    popUpWindow(context, 'Soil Moisture', 103.4, 150);

                  }
                ),
              ),
                ]
              ),
            ],
          ),
      ),
    );

}
