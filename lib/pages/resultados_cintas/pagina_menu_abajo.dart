import 'package:flutter/material.dart';

import 'PlaceholderWidget.dart';


class MostrarResultadosCintas extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MostrarResultadosCintasState();
  }
}

class MostrarResultadosCintasState extends State<MostrarResultadosCintas>{

  int _currentIndex = 0;
  final List<Widget> _children = [
   PlaceholderWidget(Colors.white),
   PlaceholderWidget(Colors.blue),
   PlaceholderWidget(Colors.green)
 ];

  void onTabTapped(int index) {
   setState(() {
     _currentIndex = index;
   });
 }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: _children[_currentIndex], 
      bottomNavigationBar: BottomNavigationBar(
      onTap: onTabTapped,
       currentIndex: _currentIndex,
       items: [
         BottomNavigationBarItem(
           icon: Icon(Icons.home),
           title: Text('Home'),
         ),
         BottomNavigationBarItem(
           icon: Icon(Icons.mail),
           title: Text('Messages'),
         ),
         BottomNavigationBarItem(
           icon: Icon(Icons.person),
           title: Text('Profile')
         )
       ],
     ),
    );
  }

}