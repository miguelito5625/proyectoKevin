import 'package:flutter/material.dart';
import '../profile_fragment/profile_fragment.dart';
import '../registrar_aereo/registrar_aereo_fragment.dart';

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class Navigation extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("Perfil", Icons.arrow_forward),
    new DrawerItem("Registrar Aéreo", Icons.arrow_forward),
    // new DrawerItem("Sockets", Icons.info)
  ];

  @override
  State<StatefulWidget> createState() {
    return new NavigationState();
  }
}

class NavigationState extends State<Navigation> {
  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new ProfileFragment();
      case 1:
        return new RegistrarAereo();
      // case 2:
      //   return new ThirdFragment();

      default:
        return new Text("Error");
    }
  }
  
  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(
        new ListTile(
          trailing: new Icon(d.icon),
          title: new Text(d.title),
          selected: i == _selectedDrawerIndex,
          onTap: () => _onSelectItem(i),
        )
      );
      // Divider(height: 2.0);
    }

    return new Scaffold(
      appBar: new AppBar(
        // here we display the title corresponding to the fragment
        // you can instead choose to have a static title
        title: new Text(widget.drawerItems[_selectedDrawerIndex].title),
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
                accountName: new Text("Kevin Salguero"), accountEmail: null),
            new Column(children: drawerOptions)
          ],
        ),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}