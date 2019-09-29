import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:sga/API/api.dart';
import 'package:sga/pages/resultados_cintas/clases/sumacolorescintas.dart';
import 'package:http/http.dart' as http;
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

class ResultadosCintas extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ResultadosCintasState();
  }
}

class ResultadosCintasState extends State<ResultadosCintas> {
  String labelFecha1 = "00/00/0000";
  String labelFecha2 = "00/00/0000";

  int amarillo = 0;
  int negro = 0;
  int rojo = 0;
  int verde = 0;
  int morado = 0;
  int cafe = 0;
  int naranja = 0;
  int azul = 0;

  String fecha1;
  String fecha2;

  Widget cargando = CircularProgressIndicator();

  Future<List<SumaColoresCintas>> _obternerSumasColores() async {
    // var fechas = {'fecha1': fecha1, 'fecha2': fecha2};
    setState(() {
      cargando = CircularProgressIndicator();
    });
    var fechas = {'fecha1': fecha1, 'fecha2': fecha2};

    var response;

    if (fecha1 == fecha2) {
      response =
          await http.post(baseUrl + '/aereos/sumacintasunafecha', body: fechas);
    } else {
      response = await http.post(baseUrl + '/aereos/sumacintasdosfechas',
          body: fechas);
    }

    if (response.statusCode == 200) {
      final items = json.decode(response.body);
      var miniFincasJson = items['suma_cintas'] as List;
      List<SumaColoresCintas> listOfSumaColores =
          miniFincasJson.map<SumaColoresCintas>((json) {
        return SumaColoresCintas.fromJson(json);
      }).toList();

      // print(listOfSumaColores[0].amarillo);

      print("El tamamnio es: " + listOfSumaColores.length.toString());

      if (listOfSumaColores.length != 0) {
        setState(() {
          

          if (listOfSumaColores[0].amarillo == null) {
            cargando = Container(
            child: Text("No hay ningun registro en las fechas seleccionadas"),
          );
            amarillo = 0;
            negro = 0;
            rojo = 0;
            verde = 0;
            morado = 0;
            cafe = 0;
            naranja = 0;
            azul = 0;
          } else {
            cargando = Container();
            amarillo = listOfSumaColores[0].amarillo;
            negro = listOfSumaColores[0].negro;
            rojo = listOfSumaColores[0].rojo;
            verde = listOfSumaColores[0].verde;
            morado = listOfSumaColores[0].morado;
            cafe = listOfSumaColores[0].cafe;
            naranja = listOfSumaColores[0].naranja;
            azul = listOfSumaColores[0].azul;
          }
        });
      } else {
        setState(() {
          amarillo = 0;
          negro = 0;
          rojo = 0;
          verde = 0;
          morado = 0;
          cafe = 0;
          naranja = 0;
          azul = 0;

          cargando = Container(
            child: Text("No hay ningun registro en las fechas seleccionadas"),
          );
        });
      }

      return listOfSumaColores;
    } else {
      throw Exception('Error de conexion de red');
    }
  }

  initState() {
    super.initState();
    DateTime now = DateTime.now();
    String hoy = formatDate(now, [yyyy, '-', mm, '-', dd]).toString();
    fecha1 = fecha2 = hoy;
    // print(fecha1);
    // print(fecha2);
    labelFecha1 = formatDate(now, [dd, '-', mm, '-', yyyy]).toString();
    labelFecha2 = formatDate(now, [dd, '-', mm, '-', yyyy]).toString();
    _obternerSumasColores();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(10.0),
      child: ListView(
        children: <Widget>[
          Center(
            child: RaisedButton(
              color: Colors.blue,
              child: Text("Abrir Calendario",
                  style: TextStyle(
                    color: Colors.white,
                  )),
              onPressed: () async {
                final List<DateTime> picked =
                    await DateRagePicker.showDatePicker(
                        context: context,
                        initialFirstDate: new DateTime.now(),
                        initialLastDate:
                            (new DateTime.now()).add(new Duration(days: 2)),
                        firstDate: new DateTime(2015),
                        lastDate: new DateTime(2020));
                if (picked != null) {
                  if (picked.length == 2) {
                    setState(() {
                      fecha1 = formatDate(picked[0], [yyyy, '-', mm, '-', dd]);
                      fecha2 = formatDate(picked[1], [yyyy, '-', mm, '-', dd]);

                      labelFecha1 =
                          formatDate(picked[0], [dd, '-', mm, '-', yyyy]);
                      labelFecha2 =
                          formatDate(picked[1], [dd, '-', mm, '-', yyyy]);
                    });
                    _obternerSumasColores();
                  }

                  if (picked.length == 1) {
                    setState(() {
                      fecha1 = formatDate(picked[0], [yyyy, '-', mm, '-', dd]);
                      fecha2 = formatDate(picked[0], [yyyy, '-', mm, '-', dd]);

                      labelFecha1 =
                          formatDate(picked[0], [dd, '-', mm, '-', yyyy]);
                      labelFecha2 =
                          formatDate(picked[0], [dd, '-', mm, '-', yyyy]);
                    });
                    _obternerSumasColores();
                  }
                }
              },
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Center(
            child: Text("Fecha seleccionada: "),
          ),
          Center(
            child: Text(labelFecha1 + " a " + labelFecha2),
          ),
          SizedBox(
            height: 10.0,
          ),
          Center(
            child: Text(
              "Totales de cintas segun la fecha seleccionada",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            children: <Widget>[
              Container(
                height: 30.0,
                width: 30.0,
                decoration: BoxDecoration(color: Colors.yellow),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Text(" = $amarillo"),
              )
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            children: <Widget>[
              Container(
                height: 30.0,
                width: 30.0,
                decoration: BoxDecoration(color: Colors.black),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Text(" = $negro"),
              )
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            children: <Widget>[
              Container(
                height: 30.0,
                width: 30.0,
                decoration: BoxDecoration(color: Colors.red),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Text(" = $rojo"),
              )
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            children: <Widget>[
              Container(
                height: 30.0,
                width: 30.0,
                decoration: BoxDecoration(color: Colors.green),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Text(" = $verde"),
              )
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            children: <Widget>[
              Container(
                height: 30.0,
                width: 30.0,
                decoration: BoxDecoration(color: Colors.purple),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Text(" = $morado"),
              )
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            children: <Widget>[
              Container(
                height: 30.0,
                width: 30.0,
                decoration: BoxDecoration(color: Color(0xFF6f4e37)),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Text(" = $cafe"),
              )
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            children: <Widget>[
              Container(
                height: 30.0,
                width: 30.0,
                decoration: BoxDecoration(color: Colors.orange),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Text(" = $naranja"),
              )
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            children: <Widget>[
              Container(
                height: 30.0,
                width: 30.0,
                decoration: BoxDecoration(color: Colors.blue),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Text(" = $azul"),
              )
            ],
          ),
          SizedBox(
            height: 25.0,
          ),
          Center(
            child: cargando,
          )
        ],
      ),
    ));
  }
}
