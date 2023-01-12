import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class plantAddScreen extends StatefulWidget {
  const plantAddScreen({Key? key}) : super(key: key);

  @override
  State<plantAddScreen> createState() => _plantAddScreenState();
}

class _plantAddScreenState extends State<plantAddScreen> {
  final GlobalKey<FormState> _formKeyValue = GlobalKey<FormState>();
  DateTime? _dateTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          "Add plant",
          style: TextStyle(
              fontSize: 27, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),

        // body:Form(
        //   key: _formKeyValue,
        //   child: ListView(
        //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
        //   children: <Widget>[
        //     const SizedBox(height: 20.0),
        //     TextFormField(
        //       decoration: const InputDecoration(
        //       icon: Icon(
        //         Icons.perm_identity_sharp,
        //         color: Colors.green,
        //       ),
        //       hintText: 'Enter the pot ID',
        //       //labelText: 'Phone',
        //       ),
        //       keyboardType: TextInputType.number
        //   ),
        //     SizedBox(height: 40.0),
        //     StreamBuilder<QuerySnapshot>(
        //         stream: Firestore.instance.collection("currency").snapshots(),
        //         builder: (context, snapshot) {
        //           if (!snapshot.hasData)
        //             const Text("Loading.....");
        //           else {
        //             List<DropdownMenuItem> currencyItems = [];
        //             for (int i = 0; i < snapshot.data.documents.length; i++) {
        //               DocumentSnapshot snap = snapshot.data.documents[i];
        //               currencyItems.add(
        //                 DropdownMenuItem(
        //                   child: Text(
        //                     snap.documentID,
        //                     style: TextStyle(color: Color(0xff11b719)),
        //                   ),
        //                   value: "${snap.documentID}",
        //                 ),
        //               );
        //             }
        //             return Row(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: <Widget>[
        //                 Icon(FontAwesomeIcons.coins,
        //                     size: 25.0, color: Color(0xff11b719)),
        //                 SizedBox(width: 50.0),
        //                 DropdownButton(
        //                   items: currencyItems,
        //                   onChanged: (currencyValue) {
        //                     final snackBar = SnackBar(
        //                       content: Text(
        //                         'Selected Currency value is $currencyValue',
        //                         style: TextStyle(color: Color(0xff11b719)),
        //                       ),
        //                     );
        //                     Scaffold.of(context).showSnackBar(snackBar);
        //                     setState(() {
        //                       selectedCurrency = currencyValue;
        //                     });
        //                   },
        //                   value: selectedCurrency,
        //                   isExpanded: false,
        //                   hint: new Text(
        //                     "Choose Currency Type",
        //                     style: TextStyle(color: Color(0xff11b719)),
        //                   ),
        //                 ),
        //               ],
        //             );
        //           }
        //         }),
    //     ])
    );
  }
}