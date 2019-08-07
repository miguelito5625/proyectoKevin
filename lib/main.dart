  
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'pages/loginpage/loginpage.dart';
import 'pages/navigation/navigation.dart';
// import 'pages/timepicker.dart';
// import 'pages/splashscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "SGA",
      theme: new ThemeData(primarySwatch: Colors.blue),
      home: new Navigation(),
    );
  }
}