import 'package:flutter/material.dart';
import 'package:sga/pages/mostrar_viajes/mostrar_todos.dart';
import 'package:sga/pages/resultados_cintas/pagina_menu_abajo.dart';
import 'package:sga/pages/resultados_cintas/resultados.dart';
import 'package:sga/streambuilder/prueba1stream.dart';
import '../profile_fragment/profile_fragment.dart';
import '../registrar_aereo/registrar_aereo_fragment.dart';

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class Navigation extends StatefulWidget {
  final drawerItems = [
     DrawerItem("Perfil", Icons.arrow_forward),
     DrawerItem("Registrar Aéreo", Icons.arrow_forward),
     DrawerItem("Mostrar Todos Los Viajes", Icons.arrow_forward),
     DrawerItem("Resultados de cintas", Icons.arrow_forward),
     DrawerItem("StreamBuilder", Icons.arrow_forward)
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
      case 2: 
        return new MostrarTodosViajes();
      case 3: 
        return new ResultadosCintas();
      case 4:
        return new Prueba1Stream();
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
        Container(
          padding: EdgeInsets.all(5.0),
          child: Card(
            child: ListTile(
          trailing: new Icon(d.icon),
          title: new Text(d.title),
          selected: i == _selectedDrawerIndex,
          onTap: () => _onSelectItem(i),
        ),
          ),
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