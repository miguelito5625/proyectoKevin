import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'navigation/navigation.dart';

class MySplashScreen extends StatefulWidget {
  @override
  _MySplashScreenState createState() => new _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 3,
      navigateAfterSeconds: new Navigation(),
      loadingText: Text("Cargando",
      style: TextStyle(color: Colors.white),),
      title: new Text('Sistema de Gestión de Aéreos (SGA)',
      style: new TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
        color: Colors.white
      ),),
      image: new Image.asset("assets/logo.png"),
      backgroundColor: Colors.blue,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      onClick: ()=>print("Sistema de Gestión de Aéreos (SGA)"),
      loaderColor: Colors.white
    );
  }
}
