import 'package:demo_payment/views/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

//Key Id
//rzp_test_dNAQDDhQO4ieb8
//key secret
//qPovSP2uM7uwmZNDwMoHQQeR

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}
