import 'package:flutter/material.dart';
// import 'clases/apiviajes.dart';
import '../../API/api.dart';
import 'clases/Viaje.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MostrarTodosViajes extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MostrarTodosViajesState();
  }
}

class MostrarTodosViajesState extends State<MostrarTodosViajes> {
  // var viajes =  new List<Viaje>();

  // Future<List<Viaje>> _fetchUsers() async {

  //    API.todosLosViajes().then((response){
  //     setState(() {
  //       // Iterable list = json.decode(response.body.viajes);
  //       final items = json.decode(response.body);
  //       var list = items['viajes'] as List;
  //       var viajes =  new List<Viaje>();
  //       viajes = list.map((model) => Viaje.fromJson(model)).toList();

  //       print("el resultado es:");

  //       return viajes;

  //     });
  //   });

  // }

  Future<List<Viaje>> _fetchUsers() async {
    var response = await http.get(baseUrl + "/aereos/mostrartodos");

    print("La respuesta es:" + response.statusCode.toString());

    if (response.statusCode == 200) {
      final items = json.decode(response.body);
      var list = items['viajes'] as List;
      var viajes = new List<Viaje>();
      viajes = list.map((model) => Viaje.fromJson(model)).toList();

      print("esto es:");
      print(viajes);

      return viajes;
    } else {
      throw Exception('Failed to load internet');
    }
  }

  initState() {
    super.initState();
    // __mostrarTodosViajes();
  }

  dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
          children: <Widget>[
      Text('LISTA',
          style: new TextStyle(
            fontSize: 15.2,
            fontWeight: FontWeight.bold,
          )),
      Container(
        decoration: BoxDecoration(
          color: Colors.blue
        ),
        height: MediaQuery.of(context).size.height - 125,
        child: FutureBuilder<List<Viaje>>(
          future: _fetchUsers(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator());

            return ListView(
              children: snapshot.data
                  .map((viaje) => Card(
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: ListTile(
                        title: Text(viaje.id.toString()),
                        subtitle: Text(viaje.id.toString()),
                        leading: CircleAvatar(
                          backgroundColor: Colors.red,
                          child: Text(viaje.id.toString(),
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ),
                  )
                      )
                  .toList(),
            );
          },
        ),
      )
    ]
    ),
        )
    );
  }
}
