import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sga/API/api.dart';
import 'package:sga/pages/registrar_aereo/clases/Aerista.dart';
import 'package:sga/pages/registrar_aereo/clases/MiniFincas.dart';
import 'clases/SeccionMiniFinca.dart';
import 'clases/Viaje.dart';
import 'package:http/http.dart' as http;

class EditarViaje extends StatefulWidget {
  final Viaje viaje;

  EditarViaje({Key key, @required this.viaje}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return EditarViajeState(viaje);
  }
}

class EditarViajeState extends State<EditarViaje> {
  // final Viaje viaje = new Viaje();
  Viaje viaje;
  EditarViajeState(this.viaje);

  bool _saving = false;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController inputAeristaController = TextEditingController();
  int idAerista;
  TextEditingController numeroViajeController = new TextEditingController();

  MiniFincas _currentMiniFinca;
  SeccionMiniFinca _currentSeccionMiniFinca;

    TextEditingController horaAereoController = new TextEditingController();
  String horaSeleccionada;

  Future<List<MiniFincas>> _obtenerMiniFincas() async {
    var response = await http.get(baseUrl + "/minifincas/list");
    if (response.statusCode == 200) {
      final items = json.decode(response.body);
      var miniFincasJson = items['miniFincas'] as List;
      List<MiniFincas> listOfMiniFincas =
          miniFincasJson.map<MiniFincas>((json) {
        return MiniFincas.fromJson(json);
      }).toList();
      return listOfMiniFincas;
    } else {
      throw Exception('Error de conexion de red');
    }
  }

  Future<List<SeccionMiniFinca>> _obtenerSeccionesMiniFincas(
      String filter) async {
    var map = new Map<String, dynamic>();
    map["filter"] = filter;
    var response =
        await http.post(baseUrl + "/seccionesmf/listfilter", body: map);
    if (response.statusCode == 200) {
      final items = json.decode(response.body);
      var miniFincasJson = items['secciones'] as List;
      List<SeccionMiniFinca> listOfSeccionMiniFinca =
          miniFincasJson.map<SeccionMiniFinca>((json) {
        return SeccionMiniFinca.fromJson(json);
      }).toList();
      if (_currentSeccionMiniFinca == null) {
        _currentSeccionMiniFinca = listOfSeccionMiniFinca[0];
      }
      return listOfSeccionMiniFinca;
    } else {
      throw Exception('Error de conexion de red');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.inputAeristaController.text = viaje.nombreAerista;
    this.idAerista = viaje.idAerista;
    this.numeroViajeController.text = viaje.numeroViaje.toString();
    _currentMiniFinca = new MiniFincas(
        id: viaje.idMiniFinca, nombre_mini_finca: viaje.nombreMiniFinca);
    _currentSeccionMiniFinca = new SeccionMiniFinca(id: viaje.idSeccionMiniFinca, seccion_mini_finca: viaje.seccionMiniFinca);
    

    // DateTime now = DateTime.now();
    horaAereoController.text = formatDate(DateTime.parse(viaje.createdAt), [hh, ':', nn, ' ', am]);
    horaSeleccionada = viaje.createdAt;
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(
          title: Text("Editar Viaje"),
        ),
        body: ModalProgressHUD(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                  ),
                  Text("Seleccione un aerista"),
                  TypeAheadFormField(
                    textFieldConfiguration: TextFieldConfiguration(
                        controller: this.inputAeristaController,
                        decoration: InputDecoration(labelText: 'Aeristas')),
                    suggestionsCallback: (pattern) async {
                      await AeristasViewModel.loadAeristas(pattern);
                      idAerista = 0;
                      return AeristasViewModel.aeristas;
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion),
                      );
                    },
                    transitionBuilder: (context, suggestionBox, controller) {
                      return suggestionBox;
                    },
                    onSuggestionSelected: (suggestion) {
                      this.inputAeristaController.text = suggestion;
                      for (Aeristas aerista
                          in AeristasViewModel.arrayAeristas) {
                        if (inputAeristaController.text ==
                            aerista.nombre_aerista) {
                          idAerista = aerista.id;
                        }
                      }
                    },
                    validator: (value) {
                      if (idAerista == 0) {
                        return 'Por favor, escoga un aerista';
                      }
                      if (value.isEmpty) {
                        return 'Por favor, escoga un aerista';
                      }
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                  ),
                  TextFormField(
                    controller: numeroViajeController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Número de viaje',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'ingrese el numero de viaje';
                      }
                    },
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text("Mini Fincas"),
                        FutureBuilder<List<MiniFincas>>(
                          future: _obtenerMiniFincas(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<MiniFincas>> snapshot) {
                            if (!snapshot.hasData)
                              return CircularProgressIndicator();
                            return DropdownButton<MiniFincas>(
                              items: snapshot.data
                                  .map((miniFinca) =>
                                      DropdownMenuItem<MiniFincas>(
                                        child:
                                            Text(miniFinca.nombre_mini_finca),
                                        value: miniFinca,
                                      ))
                                  .toList(),
                              onChanged: (MiniFincas value) {
                                setState(() {
                                  _currentMiniFinca = value;
                                  _currentSeccionMiniFinca = null;
                                });
                              },
                              isExpanded: true,
                              hint: _currentMiniFinca == null
                                  ? Text("Seleccione una mini finca")
                                  : Text(_currentMiniFinca.nombre_mini_finca),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text("Secciones"),
                        FutureBuilder<List<SeccionMiniFinca>>(
                          future: _obtenerSeccionesMiniFincas(
                              _currentMiniFinca == null
                                  ? 1
                                  : _currentMiniFinca.id.toString()),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<SeccionMiniFinca>> snapshot) {
                            if (!snapshot.hasData)
                              return CircularProgressIndicator();
                            if (_currentMiniFinca == null) {
                              return Text("Seleccione una mini finca");
                            }
                            switch (snapshot.connectionState) {
                              case ConnectionState.active:
                                return Center(
                                    child: CircularProgressIndicator());
                              default:
                                return new DropdownButton<SeccionMiniFinca>(
                                    items: snapshot.data
                                        .map((seccion) =>
                                            DropdownMenuItem<SeccionMiniFinca>(
                                              child: Text(
                                                  seccion.seccion_mini_finca),
                                              value: seccion,
                                            ))
                                        .toList(),
                                    onChanged: (SeccionMiniFinca value) {
                                      setState(() {
                                        _currentSeccionMiniFinca = value;
                                      });
                                    },
                                    isExpanded: true,
                                    hint: _currentSeccionMiniFinca == null
                                        ? Center(
                                            child: CircularProgressIndicator())
                                        : Text(_currentSeccionMiniFinca
                                            .seccion_mini_finca));
                            }
                          },
                        )
                      ],
                    ),
                  ),

                  Container(
                    child: TextField(
                      controller: horaAereoController,
                      decoration: InputDecoration(labelText: "Hora"),
                      onTap: () {
                        DatePicker.showTimePicker(context, showTitleActions: true,
                        onChanged: (date) {
                          print('change $date in time zone ' +
                          date.timeZoneOffset.inHours.toString());

                        },
                        onConfirm: (date) {
                          horaSeleccionada = date.toString();
                          String hora = formatDate(date, [hh, ':', nn, ' ', am]);
                          horaAereoController.text = hora;
                        },
                        currentTime: DateTime.parse(viaje.createdAt)
                        );
                      },
                      readOnly: true,
                    ),
                  )



                ],
              ),
            ),
          ),
          inAsyncCall: _saving,
        ));
  }
}
