import 'package:flutter/material.dart';
import 'package:flutter_demo/Modules/splash_screen.dart';
import 'package:flutter_demo/Utils/AppColor.dart';

//Created by gaurav
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Records App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Appcolor.primarySwatch,
      ),
      home: SplashScreen(),
    );
  }
}
