import 'package:flutter/material.dart';
import 'dart:async';



class Prueba1Stream extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Prueba1StreamState();
  }
}

class Prueba1StreamState extends State<Prueba1Stream>{

  int _counter = 0;
  StreamController<int> _events;

  @override
  initState() {
    super.initState();
    _events = new StreamController<int>();
    _events.add(0);
  }

  void _incrementCounter() {
      _counter++;
      _events.add(_counter);
    
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            StreamBuilder(
              stream: _events.stream,
              builder: (BuildContext context, snapshot) {
                return new Text(
                  snapshot.data.toString(),
                  style: Theme.of(context).textTheme.display1,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}