import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'clases/apiviajes.dart';
import '../../API/api.dart';
import 'clases/Viaje.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:date_format/date_format.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'editar_viaje.dart';

class MostrarTodosViajes extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MostrarTodosViajesState();
  }
}

class MostrarTodosViajesState extends State<MostrarTodosViajes> {
  //Key necesaria para el refresh del listview
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  //Fechas para filtrar la consulta de los viajes
  bool filtro = false;
  String fecha1 = "0000-00-00";
  String fecha2 = "0000-00-00";

  Future<List<Viaje>> _obtenerViajes() async {
    var fechas = {'fecha1': fecha1, 'fecha2': fecha2};

    var response;

    if (filtro == false) {
      response = await http.post(baseUrl + "/aereos/mostrartodos");
    } else {
      response =
          await http.post(baseUrl + "/aereos/mostrartodos", body: fechas);
    }

    // print("La respuesta es:" + response.statusCode.toString());

    if (response.statusCode == 200) {
      final items = json.decode(response.body);
      var list = items['viajes'] as List;
      var viajes = new List<Viaje>();
      viajes = list.map((model) => Viaje.fromJson(model)).toList();

      // print("esto es:");
      // print(viajes);

      return viajes;
    } else {
      throw Exception('Fallo de conexion');
    }
  }

  Future<void> _refresh() async {
    setState(() {
      _obtenerViajes();
    });
  }

  bool serverOnline = false;
  verificarConexionAlServidor() async {
    try {
      final result = await InternetAddress.lookup('192.168.1.9');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        serverOnline = true;
        setState(() {
          _obtenerViajes();
        });
      }
    } on SocketException catch (_) {
      print('not connected');
      serverOnline = false;
    }
  }

  initState() {
    super.initState();
  }

  dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final List<DateTime> picked = await DateRagePicker.showDatePicker(
                context: context,
                initialFirstDate: new DateTime.now(),
                initialLastDate:
                    (new DateTime.now()).add(new Duration(days: 7)),
                firstDate: new DateTime(2015),
                lastDate: new DateTime(2020));
            if (picked != null) {
              if (picked.length == 2) {
                setState(() {
                  filtro = true;
                  fecha1 = formatDate(picked[0], [yyyy, '-', mm, '-', dd]);
                  fecha2 = formatDate(picked[1], [yyyy, '-', mm, '-', dd]);
                });
                _obtenerViajes();
              }

              if (picked.length == 1) {
                setState(() {
                  filtro = true;
                  fecha1 = formatDate(picked[0], [yyyy, '-', mm, '-', dd]);
                  fecha2 = formatDate(picked[0], [yyyy, '-', mm, '-', dd]);
                });
                _obtenerViajes();
              }
            }
          },
          child: Icon(Icons.calendar_today),
        ),
        body: Container(
          color: Color(0xFFE1E1E1),
          padding: EdgeInsets.all(10.0),
          child: Container(
              padding: EdgeInsets.all(5.0),
              // decoration: BoxDecoration(
              //   color: Colors.yellow
              // ),
              // height: MediaQuery.of(context).size.height - 100,
              child: RefreshIndicator(
                onRefresh: _refresh,
                child: FutureBuilder<List<Viaje>>(
                  key: _refreshIndicatorKey,
                  future: _obtenerViajes(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {

                      const oneSec = const Duration(seconds: 3);
                      new Timer.periodic(oneSec, (Timer t) async{
                        await verificarConexionAlServidor();
                        if(serverOnline == true){
                          t.cancel();
                        }
                      } );
                      
                      return Center(child: CircularProgressIndicator());
                    }

                    return ListView(
                      children: snapshot.data
                          .map((viaje) => Card(
                                child: Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: ExpansionTile(
                                    title: Row(
                                      children: <Widget>[
                                        Expanded(
                                            child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  "Viaje",
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Text(timeago.format(
                                                    DateTime.parse(
                                                        viaje.createdAt),
                                                    locale: 'es'))
                                              ],
                                            )
                                          ],
                                        )),
                                        CircleAvatar(
                                          backgroundColor: Colors.blue,
                                          child: Text(
                                            "#" + viaje.id.toString(),
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: 10.0,
                                                left: 10.0,
                                                right: 10.0),
                                            child: Text("Aerista: " +
                                                viaje.nombreAerista),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: 10.0,
                                                left: 10.0,
                                                right: 10.0),
                                            child: Text(
                                                "Viaje del aerista No." +
                                                    viaje.numeroViaje
                                                        .toString()),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: 10.0,
                                                left: 10.0,
                                                right: 10.0),
                                            child: Text("Mini Finca: " +
                                                viaje.nombreMiniFinca),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: 10.0,
                                                left: 10.0,
                                                right: 10.0),
                                            child: Text("Seccion Mini Finca: " +
                                                viaje.seccionMiniFinca),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: 10.0,
                                                left: 10.0,
                                                right: 10.0),
                                            child: Text("Fecha: " +
                                                formatDate(
                                                    DateTime.parse(
                                                        viaje.createdAt),
                                                    [
                                                      dd,
                                                      ' de ',
                                                      MM,
                                                      ' del ',
                                                      yyyy
                                                    ])),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: 10.0,
                                                left: 10.0,
                                                right: 10.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.yellow),
                                              width: 20.0,
                                              height: 20.0,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 7.0),
                                            child: Text("  =  " +
                                                viaje.amarillo.toString()),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: 10.0,
                                                left: 10.0,
                                                right: 10.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.black),
                                              width: 20.0,
                                              height: 20.0,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 7.0),
                                            child: Text("  =  " +
                                                viaje.negro.toString()),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: 10.0,
                                                left: 10.0,
                                                right: 10.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.red),
                                              width: 20.0,
                                              height: 20.0,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 7.0),
                                            child: Text("  =  " +
                                                viaje.rojo.toString()),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: 10.0,
                                                left: 10.0,
                                                right: 10.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.green),
                                              width: 20.0,
                                              height: 20.0,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 7.0),
                                            child: Text("  =  " +
                                                viaje.verde.toString()),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: 10.0,
                                                left: 10.0,
                                                right: 10.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.purple),
                                              width: 20.0,
                                              height: 20.0,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 7.0),
                                            child: Text("  =  " +
                                                viaje.morado.toString()),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: 10.0,
                                                left: 10.0,
                                                right: 10.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF6f4e37)),
                                              width: 20.0,
                                              height: 20.0,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 7.0),
                                            child: Text("  =  " +
                                                viaje.cafe.toString()),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: 10.0,
                                                left: 10.0,
                                                right: 10.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.orange),
                                              width: 20.0,
                                              height: 20.0,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 7.0),
                                            child: Text("  =  " +
                                                viaje.naranja.toString()),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: 10.0,
                                                left: 10.0,
                                                right: 10.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.blue),
                                              width: 20.0,
                                              height: 20.0,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 7.0),
                                            child: Text("  =  " +
                                                viaje.azul.toString()),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(""),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: 10.0,
                                                left: 10.0,
                                                right: 10.0),
                                            child: RaisedButton(
                                              color: Colors.blue,
                                              child: Text("Editar",
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            EditarViaje(
                                                              viaje: viaje,
                                                            )));
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      )
                                    ],
                                    // subtitle: Text(viaje.id.toString()),
                                    // leading: CircleAvatar(
                                    //   backgroundColor: Colors.red,
                                    //   child: Text(viaje.id.toString(),
                                    //       style: TextStyle(
                                    //         fontSize: 18.0,
                                    //         color: Colors.white,
                                    //       )),
                                    // ),
                                  ),
                                ),
                              ))
                          .toList(),
                    );
                  },
                ),
              )),
        ));
  }
}
