import 'package:flutter/material.dart';
import 'package:news_app/views/front.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
      title:"FLICKNEWS", 
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.blueAccent),
        home: FrontPage(),
      ));
} 
