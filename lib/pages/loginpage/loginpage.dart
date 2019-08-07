import '../navigation/navigation.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  // LoginPage({
  //   Key key,
  //   this.title
  //   }) : super(key: key);

  // final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextEditingController userTextController = new TextEditingController();
  TextEditingController passwordTextController = new TextEditingController();

  _getUserNameAndPassword() {
    print(userTextController.value);
  }


  @override
  Widget build(BuildContext context) {
    _clickLoginButton() {
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeft,
              duration: Duration(milliseconds: 500),
              child: Navigation()));
    }

    final userField = TextField(
      controller: userTextController,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Usuario",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final passwordField = TextField(
      controller: passwordTextController,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Contraseña",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          
          _clickLoginButton();

        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: new AppBar(
          title: Text("Inicio de sesion"),
        ),
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
                      height: 155.0,
                      child: Image.asset(
                        "assets/logo.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 45.0),
                    userField,
                    SizedBox(height: 25.0),
                    passwordField,
                    SizedBox(
                      height: 35.0,
                    ),
                    loginButon,
                    SizedBox(
                      height: 115.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}