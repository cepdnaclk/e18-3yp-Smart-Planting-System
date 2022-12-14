import 'package:flutter/material.dart';

class plantScreen extends StatefulWidget {
  const plantScreen({Key? key}) : super(key: key);

  @override
  State<plantScreen> createState() => _plantScreenState();
}

class _plantScreenState extends State<plantScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('plant 1'),
        centerTitle: true,
      ),
      body: buildPlant(),
    );
  }

 Widget buildPlant() => ListView(
   padding: const EdgeInsets.all(20),
   children: [
     Container(
       decoration: const BoxDecoration(
           color: Colors.black26,
           borderRadius: BorderRadius.all(Radius.circular(20))
       ),
       height: 550,
       width: 320,
       child: Column(
         children: [
           const SizedBox(height: 40,),
           Image.asset('asset/login.jpg', scale: 4,),
           const SizedBox(height: 100,),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               FloatingActionButton(
                 onPressed: () {},
                 backgroundColor: Colors.lightGreen,
                 child: Image.network('https://www.iconsdb.com/icons/preview/green/sun-4-xxl.png', scale: 8),
               ),
               const SizedBox(width: 50,),
               FloatingActionButton(
                 onPressed: () {},
                 backgroundColor: Colors.lightGreen,
                 child: Image.network('https://www.iconsdb.com/icons/preview/green/temperature-2-xxl.png', scale: 8),
               ),
             ],
           ),
           const SizedBox(height: 50,),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               FloatingActionButton(
                 onPressed: () {},
                 backgroundColor: Colors.lightGreen,
                 child: Image.network('https://www.iconsdb.com/icons/preview/green/water-9-xxl.png', scale: 8),
               ),
               const SizedBox(width: 50,),
               FloatingActionButton(
                 onPressed: () {},
                 backgroundColor: Colors.lightGreen,
                 child: Image.network('https://www.iconsdb.com/icons/preview/green/eye-3-xxl.png', scale: 8),
               ),
             ],
           ),
         ],
       ),
     ),

   ]
 );
}
