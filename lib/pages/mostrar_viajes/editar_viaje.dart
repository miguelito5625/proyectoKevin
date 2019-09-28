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

import 'clases/viaje_aereo.dart';

class EditarViaje extends StatefulWidget {
  final Viaje viaje;

  EditarViaje({Key key, @required this.viaje}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return EditarViajeState(viaje);
  }
}

class EditarViajeState extends State<EditarViaje> {

    final _scaffoldKey = GlobalKey<ScaffoldState>();

  static final urlApiServer = baseUrl + '/aereos/editaraereo';
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

  int conteoCintaAmarilla = 0;
  int conteoCintaNegra = 0;
  int conteoCintaRoja = 0;
  int conteoCintaVerde = 0;
  int conteoCintaMorada = 0;
  int conteoCintaCafe = 0;
  int conteoCintaNaranja = 0;
  int conteoCintaAzul = 0;

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

  _viajeGuardadoSB() {
    final snackBar = SnackBar(
            content: Text('Viaje Guardado'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          );

          // Scaffold.of(context).showSnackBar(snackBar);
          _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  _errorAlGuardarSB() {
    final snackBar = SnackBar(
            content: Text('Error'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          );

          // Scaffold.of(context).showSnackBar(snackBar);
          _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  Future<void> editarViajeAereo(String url, {Map body}) async {
    try {
      var client = http.Client();
      var response =
          await client.post(Uri.encodeFull(url), body: body).whenComplete(() {
        client.close();
      });

      setState(() {
        _saving = false;
      });

      print(response.body);
      if(response.body == 'ok'){
         _viajeGuardadoSB();
      }else{
        _errorAlGuardarSB();
      }
      
    } catch (e) {

      setState(() {
        _saving = false;
      });

      print("ocurrio un error: " + e.toString());
      _errorAlGuardarSB();
      
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
    horaAereoController.text = formatDate(DateTime.parse(viaje.createdAt), [h, ':', nn, ' ', am]);
    print(viaje.createdAt);
    print(horaAereoController.text);
    horaSeleccionada = viaje.createdAt;

   conteoCintaAmarilla = viaje.amarillo;
   conteoCintaNegra = viaje.negro;
   conteoCintaRoja = viaje.rojo;
   conteoCintaVerde = viaje.verde;
   conteoCintaMorada = viaje.morado;
   conteoCintaCafe = viaje.cafe;
   conteoCintaNaranja = viaje.naranja;
   conteoCintaAzul = viaje.azul;

  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
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
                          print(date.toString());
                          horaSeleccionada = date.toString();
                          String hora = formatDate(date, [hh, ':', nn, ' ', am]);
                          horaAereoController.text = hora;
                        },
                        currentTime: DateTime.parse(formatDate(DateTime.parse(viaje.createdAt), [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss]))
                        );
                      },
                      readOnly: true,
                    ),
                  ),
                  Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Container(
                  width: screenSize.width,
                  child: Text("Colores de cinta:"),
                ),
              ),



              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Container(
                          child: SizedBox(
                            child: Row(
                              children: <Widget>[
                                IconButton(
                                  color: Colors.white,
                                  icon: Icon(Icons.remove),
                                  onPressed: () {
                                    if (conteoCintaAmarilla != 0) {
                                      setState(() {
                                        conteoCintaAmarilla =
                                            conteoCintaAmarilla - 1;
                                      });
                                    }
                                  },
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 15.0, right: 15.0),
                                  child: Text(
                                    conteoCintaAmarilla.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                IconButton(
                                  color: Colors.white,
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    setState(() {
                                      conteoCintaAmarilla =
                                          conteoCintaAmarilla + 1;
                                    });
                                  },
                                )
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(30.0))),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 25.0),
                      child: Container(
                          child: SizedBox(
                            child: Row(
                              children: <Widget>[
                                IconButton(
                                  color: Colors.white,
                                  icon: Icon(Icons.remove),
                                  onPressed: () {
                                    if (conteoCintaNegra != 0) {
                                      setState(() {
                                        conteoCintaNegra = conteoCintaNegra - 1;
                                      });
                                    }
                                  },
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 15.0, right: 15.0),
                                  child: Text(
                                    conteoCintaNegra.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                IconButton(
                                  color: Colors.white,
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    setState(() {
                                      conteoCintaNegra = conteoCintaNegra + 1;
                                    });
                                  },
                                )
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(30.0))),
                    )
                  ],
                ),
              ),



              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Container(
                          child: SizedBox(
                            child: Row(
                              children: <Widget>[
                                IconButton(
                                  color: Colors.white,
                                  icon: Icon(Icons.remove),
                                  onPressed: () {
                                    if (conteoCintaRoja != 0) {
                                      setState(() {
                                        conteoCintaRoja = conteoCintaRoja - 1;
                                      });
                                    }
                                  },
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 15.0, right: 15.0),
                                  child: Text(
                                    conteoCintaRoja.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                IconButton(
                                  color: Colors.white,
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    setState(() {
                                      conteoCintaRoja = conteoCintaRoja + 1;
                                    });
                                  },
                                )
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(30.0))),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 25.0),
                      child: Container(
                          child: SizedBox(
                            child: Row(
                              children: <Widget>[
                                IconButton(
                                  color: Colors.white,
                                  icon: Icon(Icons.remove),
                                  onPressed: () {
                                    if (conteoCintaVerde != 0) {
                                      setState(() {
                                        conteoCintaVerde = conteoCintaVerde - 1;
                                      });
                                    }
                                  },
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 15.0, right: 15.0),
                                  child: Text(
                                    conteoCintaVerde.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                IconButton(
                                  color: Colors.white,
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    setState(() {
                                      conteoCintaVerde = conteoCintaVerde + 1;
                                    });
                                  },
                                )
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(30.0))),
                    )
                  ],
                ),
              ),




              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Container(
                          child: SizedBox(
                            child: Row(
                              children: <Widget>[
                                IconButton(
                                  color: Colors.white,
                                  icon: Icon(Icons.remove),
                                  onPressed: () {
                                    if (conteoCintaMorada != 0) {
                                      setState(() {
                                        conteoCintaMorada =
                                            conteoCintaMorada - 1;
                                      });
                                    }
                                  },
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 15.0, right: 15.0),
                                  child: Text(
                                    conteoCintaMorada.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                IconButton(
                                  color: Colors.white,
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    setState(() {
                                      conteoCintaMorada = conteoCintaMorada + 1;
                                    });
                                  },
                                )
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(30.0))),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 25.0),
                      child: Container(
                          child: SizedBox(
                            child: Row(
                              children: <Widget>[
                                IconButton(
                                  color: Colors.white,
                                  icon: Icon(Icons.remove),
                                  onPressed: () {
                                    if (conteoCintaCafe != 0) {
                                      setState(() {
                                        conteoCintaCafe--;
                                      });
                                    }
                                  },
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 15.0, right: 15.0),
                                  child: Text(
                                    conteoCintaCafe.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                IconButton(
                                  color: Colors.white,
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    setState(() {
                                      conteoCintaCafe++;
                                    });
                                  },
                                )
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Color(0xFF6f4e37),
                              borderRadius: BorderRadius.circular(30.0))),
                    ),
                  ],
                ),
              ),




              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Container(
                          child: SizedBox(
                            child: Row(
                              children: <Widget>[
                                IconButton(
                                  color: Colors.white,
                                  icon: Icon(Icons.remove),
                                  onPressed: () {
                                    if (conteoCintaNaranja != 0) {
                                      setState(() {
                                        conteoCintaNaranja--;
                                      });
                                    }
                                  },
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 15.0, right: 15.0),
                                  child: Text(
                                    conteoCintaNaranja.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                IconButton(
                                  color: Colors.white,
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    setState(() {
                                      conteoCintaNaranja++;
                                    });
                                  },
                                )
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(30.0))),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 25.0),
                      child: Container(
                          child: SizedBox(
                            child: Row(
                              children: <Widget>[
                                IconButton(
                                  color: Colors.white,
                                  icon: Icon(Icons.remove),
                                  onPressed: () {
                                    if (conteoCintaAzul != 0) {
                                      setState(() {
                                        conteoCintaAzul--;
                                      });
                                    }
                                  },
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 15.0, right: 15.0),
                                  child: Text(
                                    conteoCintaAzul.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                IconButton(
                                  color: Colors.white,
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    setState(() {
                                      conteoCintaAzul++;
                                    });
                                  },
                                )
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(30.0))),
                    ),
                  ],
                ),
              ),


               Container(
                width: screenSize.width,
                height: 50.0,
                child: RaisedButton(
                  color: Colors.blue,
                  child: Text(
                    'Guardar',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  onPressed: () {
                    // print('el aerista es   ' + inputAeristaController.text.substring(0,1));
                    // print("el id del aerista es: " + idAerista.toString());

                    if (_formKey.currentState.validate()) {
                      print("enviando al server");

                      setState(() {
                        _saving = true;
                      });

                      ViajeAereo nuevoViaje = new ViajeAereo(
                          numero_viaje: numeroViajeController.text,
                          id_aerista: idAerista.toString(),
                          created_at: formatDate(DateTime.parse(horaSeleccionada), [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss]),
                          id_mini_finca: _currentMiniFinca.id.toString(),
                          id_seccion_mini_finca: _currentSeccionMiniFinca.id.toString(),
                          amarillo: conteoCintaAmarilla.toString(),
                          negro: conteoCintaNegra.toString(),
                          rojo: conteoCintaRoja.toString(),
                          verde: conteoCintaVerde.toString(),
                          morado: conteoCintaMorada.toString(),
                          cafe: conteoCintaCafe.toString(),
                          naranja: conteoCintaNaranja.toString(),
                          azul: conteoCintaAzul.toString(),
                          id: viaje.id.toString());

                      editarViajeAereo(urlApiServer, body: nuevoViaje.toMap());
                    }
                  },
                ),
                margin: EdgeInsets.all(20.0),
              )


                ],
              ),
            ),
          ),
          inAsyncCall: _saving,
        ));
  }
}
