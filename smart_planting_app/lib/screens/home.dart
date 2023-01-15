//import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_planting_app/screens/Plant_reg_page.dart';
import 'package:smart_planting_app/screens/community.dart';
import 'package:smart_planting_app/screens/profile.dart';
import 'package:smart_planting_app/screens/profile.dart';
import 'package:smart_planting_app/screens/plant_add.dart';
import 'package:smart_planting_app/screens/register.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:smart_planting_app/screens/timeline.dart';

List<Widget> adds = [];
final stream1 = FirebaseFirestore.instance.collection('Plants_Database').snapshots();
final stream2 = FirebaseFirestore.instance.collection('Plants_Data').snapshots();

String soilMoisture="";
String waterLevel="";
String lightIntensity="";
int temperature=0;

String reqSoil = "";
String reqWater = "";
int reqTemp = 0;
String reqLight="";

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {

  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          elevation: 0,
          title: const Text('Home', style: TextStyle(color: Colors.black)),
          centerTitle: true,
          leading: IconButton(
            icon: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Image.asset('asset/community.png', scale: 5,),
            ),
            color: Colors.black,
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const timelineScreen())),
          ),
          actions: [
            IconButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)
                => profileScreen(profileId: currentUser.id,))),
                icon: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(currentUser.photoUrl),
                ))
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

  String? plantTypeId;

  addPlant(BuildContext context,String plantName,String TypeId,int potId) {
    //adds.add(buildPlant(context, plantName));
    adds.add(buildData(context,plantName,TypeId,potId));
    //buildData(context,plantName,TypeId);
    plantTypeId = TypeId;
  }

  Future popUpWindow(BuildContext context, String title, var currentData, var requiredData) => showDialog(
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
                  child: const Text('Ok'),
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

  // Future<Widget> buildData(BuildContext context) async {
  //
  //   return StreamBuilder(
  //     stream: stream1,
  //     builder:(context,snapshot1) {
  //       if(!snapshot1.hasData){
  //         return Text("Loading");
  //       }
  //       else{
  //         return StreamBuilder(
  //             stream: stream2,
  //             builder: (context,snapshot2){
  //               if(!snapshot2.hasData){
  //                 return Text("Loading");
  //               }
  //               else{
  //                 return Text("Hi");
  //               }
  //             });
  //       }
  //     }
  //   );
  //}

    Widget buildData (BuildContext context,String plantName,String plantID,int potID) =>
        StreamBuilder(
          stream: stream1,
          builder: (context,snapshot1){
            if(!snapshot1.hasData){
              return Text("Loading1");
            }
            else{
              for (int i = 0; i < snapshot1.data!.docs.length; i++) {
                DocumentSnapshot snap = snapshot1.data!.docs[i];

                if(snap.id == plantID){
                  reqSoil = snap.get("soilMoisture");
                  reqWater = "level3";
                  reqTemp = snap.get("maxTemp");
                  reqLight = snap.get("shade");
                }
              }

              StreamBuilder(
                stream: stream2,
                builder: (context,snapshot2){
                  if(!snapshot2.hasData){
                    print("check");
                    return Text("Loading2");
                  }
                  else{
                    for (int i = 0; i < snapshot2.data!.docs.length; i++) {
                      DocumentSnapshot snap = snapshot2.data!.docs[i];

                      print(snap.id);
                      //print("check");
                      if(int.parse(snap.id)== potID){
                        soilMoisture = snap.get("SoilMoisture");
                        waterLevel = snap.get("WaterLevel");
                        temperature = snap.get("Temperature");
                        lightIntensity = snap.get("LightIntensity");
                      }
                    }
                  }
                  return Text("Done");
                },
              );
              //print(potID);
              return buildPlant(context,plantName,reqSoil,reqWater,reqTemp,reqLight,soilMoisture,waterLevel,temperature,lightIntensity);
            }
          }
      );


    Widget buildPlant(BuildContext context,String plantType,String reqSoil,String reqWater,int reqTemp,String reqLight,String soil,String water,int temp,String light) => Padding(
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
                      popUpWindow(context, 'Light Intensity', light, reqLight);
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
                      popUpWindow(context, 'Temperature', temp, reqTemp);
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
                        popUpWindow(context, 'Water Level', water, reqWater);
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
                          popUpWindow(context, 'Soil Moisture', soil, reqSoil);

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
