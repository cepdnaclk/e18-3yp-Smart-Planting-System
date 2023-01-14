import 'dart:core';

import 'package:flutter/material.dart';
import 'package:smart_planting_app/screens/home.dart';
import 'package:smart_planting_app/screens/plant.dart';
import 'package:smart_planting_app/Models/PlantModel.dart';
import 'package:smart_planting_app/screens/progress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as cnv;



class plantRegScreen extends StatefulWidget {
  const plantRegScreen({Key? key}) : super(key: key);

  @override
  State<plantRegScreen> createState() => _plantRegScreenState();
}

class _plantRegScreenState extends State<plantRegScreen> {
 // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? dropDownVal;
  String? plantTpID;
  DateTime? _dateTime;

  Plant plant1 = Plant(
      plantTypeID: '',
      plantType: '',
      about: '',
      plantID: 0,
      scientificName: '');

  late String _name;
  late String _email;
  late String _password;
  late String _confirmPwd;
  late int _mobile;

  String plantID ="";

  late List<PlantModel> plantModel = [];


  @override
  void initState() {
    // getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Here is the data");
    late List<String> items = [];


    for (int i = 0; i < plantModel.length; i++) {
      items.add(plantModel[i].commonName ?? "");
    }

    const color = Colors.lightGreen;


    return Scaffold(
      backgroundColor: Colors.white,
      // body: isLoading ?
      body: plantModel.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
      child: Scaffold(
      backgroundColor: Colors.white,
       body : Container(
              margin: const EdgeInsets.all(24.0),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      height: 40,
                      width: 300,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black54,
                              ),
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0),
                              )),
                          alignLabelWithHint: false,
                          contentPadding:
                              const EdgeInsets.only(top: 5, left: 8, right: 5),
                          filled: true,
                          fillColor: Colors.green.shade100,
                          label: Text(
                            'Plant ID',
                            style:
                                TextStyle(fontSize: 15, color: Colors.black87),
                          ),
                          hintText: 'Type the pot ID',
                          hintStyle: const TextStyle(
                              fontSize: 15, color: Colors.black54),
                        ),
                        cursorColor: Colors.green,
                        keyboardType: TextInputType.number,
                        style:
                            const TextStyle(fontSize: 15, color: Colors.black),
                        onChanged: (plantID) {
                          plant1.plantID = int.parse(plantID);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black45,
                          ),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green.shade100,
                        ),
                        height: 40,
                        width: 300,
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: DropdownButton<String>(
                          icon: const Icon(
                            Icons.arrow_drop_down_outlined,
                            color: Colors.green,
                            size: 40,
                          ),
                          alignment: Alignment.centerLeft,
                          borderRadius: BorderRadius.circular(10),
                          menuMaxHeight: 300,
                          underline: Container(
                            color: Colors.transparent,
                          ),
                          dropdownColor: Colors.grey.shade300,
                          hint: const Text(
                            'Select Plant Type                        ',
                            style: TextStyle(fontSize: 18),
                          ),
                          value: dropDownVal,
                          items: items
                              .map((item) => DropdownMenuItem(
                                  value: item, child: Text(item)))
                              .toList(),
                          onChanged: (item) {
                            dropDownVal = item;
                            plant1.plantType = item;
                            setState(() {});
                          },
                        ),
                      ),
                    ),

                    StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance.collection("Plants_Database").snapshots(),
                        builder: (context, snapshot){
                          if (!snapshot.hasData) {
                          return circularProgress();
                          }
                            for (int i = 0; i < snapshot.data!.docs.length; i++) {
                              DocumentSnapshot snap = snapshot.data!.docs[i];
                              String name = snap.get("commonName");
                              items.add(name);
                            }
                            return Padding(
                              padding: const EdgeInsets.all(5),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black45,
                                  ),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.green.shade100,
                                ),
                                height: 40,
                                width: 300,
                                padding: EdgeInsets.only(left: 5, right: 5),
                                child: DropdownButton<String>(
                                  icon: const Icon(
                                    Icons.arrow_drop_down_outlined,
                                    color: Colors.green,
                                    size: 40,
                                  ),
                                  alignment: Alignment.centerLeft,
                                  borderRadius: BorderRadius.circular(10),
                                  menuMaxHeight: 300,
                                  underline: Container(
                                    color: Colors.transparent,
                                  ),
                                  dropdownColor: Colors.grey.shade300,
                                  hint: const Text(
                                    'Select Plant Type                        ',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  items: items
                                      .map((item) => DropdownMenuItem(
                                      value: item,child: Text(item)))
                                      .toList(),
                                  onChanged: (val) {
                                    //dropDownVal = val;
                                    plant1.plantType = val;
                                    print(plant1.plantType);
                                    setState((){});
                                  },
                                  value:dropDownVal,
                                ),
                              ),
                            );
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(300.0, 40.0),
                            backgroundColor: Colors.green.shade100,
                            elevation: 0,
                            alignment: Alignment.centerLeft,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            side: BorderSide(color: Colors.black45)),
                        child: _dateTime == null
                            ? Text(
                                'Date',
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 20),
                              )
                            : Text(
                                _dateTime.toString().substring(0, 10),
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 20),
                              ),
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2022),
                            lastDate: DateTime(2100),
                          ).then((date) {
                            setState(() {
                              _dateTime = date;
                            });
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 40),
                    Container(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          minimumSize: const Size(120.0, 40.0),
                          //side: BorderSide(color: Colors.yellow, width: 5),
                          textStyle: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          shape: const StadiumBorder(
                              side: BorderSide(color: Colors.green)),
                          shadowColor: Colors.black,
                        ),
                        child: const Text(
                          'Add Plant',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          addPlant(context, plant1.plantType!);
                          // Get ID from List
                          setPlantTypeID();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const homeScreen()));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
        )
      )
    );
  }

  
  // API calls
  Future<void> getData() async {
    Uri url = Uri.http('3.111.170.113:8000', '/api/plantData');
    http.Response res = await http.get(url);
    print(res.body);
    List<dynamic> body = cnv.jsonDecode(res.body);
    plantModel = body.map((dynamic item) => PlantModel.fromJson(item)).toList();
    setState(() {});

  }


  setPlantTypeID() {
    for (int i = 0; i < plantModel.length; i++) {
      if (plantModel[i].commonName == plant1.plantType) {
        plant1.plantTypeID = plantModel[i].plantTypeID;
        continue;
      }
    }
    setState(() {});
  }
}
