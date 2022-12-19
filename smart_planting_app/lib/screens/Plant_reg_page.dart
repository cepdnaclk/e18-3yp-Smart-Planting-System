import 'package:flutter/material.dart';
import 'package:smart_planting_app/screens/home.dart';
import 'package:smart_planting_app/screens/plant.dart';

class plantRegScreen extends StatefulWidget {
  const plantRegScreen({Key? key}) : super(key: key);

  @override
  State<plantRegScreen> createState() => _plantRegScreenState();
}

class _plantRegScreenState extends State<plantRegScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? dropDownVal;
  DateTime? _dateTime;

  Plant plant1 = Plant(plantType: '', about: '', plantID: '', scientificName: '');

  late String _name;
  late String _email;
  late String _password;
  late String _confirmPwd;
  late int _mobile;

  @override
  Widget build(BuildContext context) {
    final color = Colors.lightGreen;
    List<String> items = [
      'plant 1', 'plant 2', 'plant 3', 'plant 4', 'plant 5'
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 50,),
              Container(
                height: 40,
                width: 300,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black54, ),
                        borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),)
                    ),
                    alignLabelWithHint: false,
                    contentPadding: EdgeInsets.only(top: 5, left: 8, right: 5),
                    filled: true,
                    fillColor: Colors.green.shade100,
                    label: Text('Plant ID', style: TextStyle(fontSize: 15, color: Colors.black87),),
                    hintText: 'Type the pot ID',
                    hintStyle: TextStyle(fontSize: 15, color: Colors.black54),
                  ),
                  cursorColor: Colors.green,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 15, color: Colors.black),
                  onChanged: (plantID) {
                    plant1.plantID = plantID;
                  },
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: EdgeInsets.all(5),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black45,),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green.shade100,
                  ),
                  height: 40,
                  width: 300,
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: DropdownButton<String> (
                    icon: Icon(Icons.arrow_drop_down_outlined,  color: Colors.green, size: 40,),
                    alignment: Alignment.centerLeft,
                    borderRadius: BorderRadius.circular(10),
                    menuMaxHeight: 300,
                    underline: Container(color: Colors.transparent,),
                    dropdownColor: Colors.grey.shade300,
                    hint: Text('Select Plant Type                        ', style: TextStyle(fontSize: 18),),
                    value: dropDownVal,
                    items: items.map((item) => DropdownMenuItem(
                        value: item,
                        child: Text(item)
                      )
                    ).toList(),
                    onChanged: (item) {
                      dropDownVal = item;
                      plant1.plantType = item;
                      setState(() {});
                    },
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(300.0, 40.0),
                    backgroundColor: Colors.green.shade100,
                    elevation: 0,
                    alignment: Alignment.centerLeft,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    side: BorderSide(color: Colors.black45)
                  ),
                  child: _dateTime == null? Text('Date', style: TextStyle(color: Colors.black45, fontSize: 20),)
                      : Text(_dateTime.toString().substring(0, 10), style: TextStyle(color: Colors.black45, fontSize: 20),),
                  onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2022),
                        lastDate: DateTime(2100),
                        ).then((date)  {
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
                    primary: Colors.white,
                    minimumSize: const Size(120.0, 40.0),
                    //side: BorderSide(color: Colors.yellow, width: 5),
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    shape: const StadiumBorder(side: BorderSide(color: Colors.green)),
                    shadowColor: Colors.black,
                  ),
                  child: const Text(
                    'Add Plant',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    addPlant(dropDownVal!);
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const homeScreen()));
                  },
                ),
              ),
            ],
          ),
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

