import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:try1/home_page.dart';

void main() async {
 await Hive.initFlutter();

 var box = await Hive.openBox("mytodobox");


  runApp(const MyApp());

  
}

class MyApp extends StatelessWidget {
   const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
     theme: ThemeData(primarySwatch: Colors.deepPurple ) ,
    );
    
  }
}
