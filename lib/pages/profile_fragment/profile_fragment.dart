// import 'dart:io';
import 'dart:async';
// import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

class ProfileFragment extends StatefulWidget {
  // final Future<Post> post;
  // ProfileFragment({Key key, this.post}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProfileFragmentState();
  }
}

class ProfileFragmentState extends State<ProfileFragment> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 150.0,
                      child: Image.asset(
                        "assets/unknown_user.png",
                        // fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 45.0),
                    Text(
                      "Kevin Salguero",
                      style: TextStyle(fontSize: 35.0),
                    ),
                    SizedBox(height: 45.0),
                    Text(
                      "Bienvenido al Sistema de Gestión de Aéreos (SGA)",
                      style: TextStyle(fontSize: 24.0),
                    )
                    // userField,
                    // SizedBox(height: 25.0),
                    // passwordField,
                    // SizedBox(
                    //   height: 35.0,
                    // ),
                    // loginButon,
                    // SizedBox(
                    //   height: 115.0,
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}