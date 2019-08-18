import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'clases/SeccionMiniFinca.dart';
import 'clases/MiniFincas.dart';
import 'package:http/http.dart' as http;
import 'clases/viaje_aereo.dart';
import 'clases/Aerista.dart';

class RegistrarAereo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new RegistrarAereoState();
  }
}

class RegistrarAereoState extends State<RegistrarAereo> {
  static final urlApiServer = 'http://192.168.1.9:3000/aereos/add';
  final _formKey = GlobalKey<FormState>();

  RegistrarAereoState();

  TextEditingController nombreAeristaController = new TextEditingController();
  // String selectedAerista = '';

  TextEditingController numeroViajeController = new TextEditingController();
  TextEditingController horaAereoController = new TextEditingController();
  TextEditingController countCintaAmarillaController =
      new TextEditingController();
  TextEditingController countCintaNegraController = new TextEditingController();
  TextEditingController countCintaRojaController = new TextEditingController();
  TextEditingController countCintaVerdeController = new TextEditingController();
  TextEditingController countCintaMoradaController =
      new TextEditingController();
  TextEditingController countCintaCafeController = new TextEditingController();
  TextEditingController countCintaNaranjaController =
      new TextEditingController();
  TextEditingController countCintaAzulController = new TextEditingController();

  int conteoCintaAmarilla = 0;
  int conteoCintaNegra = 0;
  int conteoCintaRoja = 0;
  int conteoCintaVerde = 0;
  int conteoCintaMorada = 0;
  int conteoCintaCafe = 0;
  int conteoCintaNaranja = 0;
  int conteoCintaAzul = 0;

  String horaSeleccionada;

  final TextEditingController inputAeristaController = TextEditingController();
  int idAerista;
  // String selectedAerista;

  MiniFincas _currentMiniFinca;

  Future<List<MiniFincas>> _fetchMiniFincas() async {
    var response = await http.get('http://192.168.1.9:3000/minifincas/list');
    if (response.statusCode == 200) {
      final items = json.decode(response.body);
      var miniFincasJson = items['miniFincas'] as List;
      List<MiniFincas> listOfMiniFincas = miniFincasJson.map<MiniFincas>((json) {
        return MiniFincas.fromJson(json);
      }).toList();
      // print(listOfMiniFincas[0].nombre_mini_finca);
      // _currentMiniFinca =  listOfMiniFincas[0];
      return listOfMiniFincas;
    } else {
      throw Exception('Error de conexion de red');
    }
  }

  SeccionMiniFinca _currentSeccionMiniFinca;

  Future<List<SeccionMiniFinca>> _fetchSeccionMiniFincas(String filter) async {
    var map = new Map<String, dynamic>();
    map["filter"] = filter;
    var response = await http.post('http://192.168.1.9:3000/seccionesmf/listfilter', body: map);
    if (response.statusCode == 200) {
      final items = json.decode(response.body);
      var miniFincasJson = items['secciones'] as List;
      List<SeccionMiniFinca> listOfSeccionMiniFincas = miniFincasJson.map<SeccionMiniFinca>((json) {
        return SeccionMiniFinca.fromJson(json);
      }).toList();
      // _currentSeccionMiniFinca = listOfSeccionMiniFincas[0];
      return listOfSeccionMiniFincas;
    } else {
      throw Exception('Error de conexion de red');
    }
  }


  // List<DropdownMenuItem<String>> _dropDownMenuItemsMiniFincas;
  // List<DropdownMenuItem<String>> _dropDownMenuItemsMiniFincasSecciones;
  // String _selectedMiniFinca;
  // String _selectedMiniFincaSeccion;

  // List<DropdownMenuItem<String>> buildAndGetDropDownMenuItemsMiniFincas(
  //     List miniFincas) {
  //   List<DropdownMenuItem<String>> items = new List();
  //   for (MiniFincas miniFinca in miniFincas) {
  //     items.add(DropdownMenuItem(
  //         value: miniFinca.miniFinca, child: Text(miniFinca.miniFinca)));
  //   }
  //   return items;
  // }

  // void changedDropDownItemMiniFincsa(String selectedMiniFinca) {
  //   setState(() {
  //     _selectedMiniFinca = selectedMiniFinca;
  //     _dropDownMenuItemsMiniFincasSecciones =
  //         buildAndGetDropDownMenuItemsMiniFincasSecciones(
  //             arraySeccionMiniFincas);
  //     _selectedMiniFincaSeccion =
  //         _dropDownMenuItemsMiniFincasSecciones[0].value;
  //   });
  // }

  // List<DropdownMenuItem<String>>
  //     buildAndGetDropDownMenuItemsMiniFincasSecciones(List secciones) {
  //   List<DropdownMenuItem<String>> items = new List();
  //   for (SeccionMiniFinca seccion in secciones) {
  //     if (seccion.miniFinca == _selectedMiniFinca) {
  //       items.add(DropdownMenuItem(
  //           value: seccion.seccion, child: Text(seccion.seccion)));
  //     }
  //   }
  //   return items;
  // }

  // void changedDropDownItemMiniFincsaSecciones(String selectedMiniFincaSeccion) {
  //   setState(() {
  //     _selectedMiniFincaSeccion = selectedMiniFincaSeccion;
  //   });
  // }

  Future<void> createViajeAereo(String url, {Map body}) async {
    try {
      var client = http.Client();
      var response =
          await client.post(Uri.encodeFull(url), body: body).whenComplete(() {
        client.close();
      });
      print(response.body);
    } catch (e) {
      print("ocurrio un error: " + e.toString());
    }
  }

  @override
  void initState() {
    super.initState();

    countCintaAmarillaController.text = conteoCintaAmarilla.toString();
    countCintaNegraController.text = conteoCintaNegra.toString();
    countCintaRojaController.text = conteoCintaRoja.toString();
    countCintaVerdeController.text = conteoCintaVerde.toString();
    countCintaMoradaController.text = conteoCintaMorada.toString();
    countCintaCafeController.text = conteoCintaCafe.toString();
    countCintaNaranjaController.text = conteoCintaNaranja.toString();
    countCintaAzulController.text = conteoCintaAzul.toString();

    // _dropDownMenuItemsMiniFincas =
    //     buildAndGetDropDownMenuItemsMiniFincas(arrayMiniFincas);
    // _selectedMiniFinca = _dropDownMenuItemsMiniFincas[0].value;

    // _dropDownMenuItemsMiniFincasSecciones =
    //     buildAndGetDropDownMenuItemsMiniFincasSecciones(arraySeccionMiniFincas);
    // _selectedMiniFincaSeccion = _dropDownMenuItemsMiniFincasSecciones[0].value;

    DateTime now = DateTime.now();
    horaAereoController.text = formatDate(now, [hh, ':', nn, ' ', am]);
    horaSeleccionada = now.toString();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return new Scaffold(
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10.0),
              ),
              Text('Seleccione un aerista'),
              TypeAheadFormField(
                textFieldConfiguration: TextFieldConfiguration(
                    controller: this.inputAeristaController,
                    decoration: InputDecoration(labelText: 'Aeristas')),
                suggestionsCallback: (pattern) async {
                  await AeristasViewModel.loadAeristas(pattern);
                  idAerista = 0;
                  // print(AeristasViewModel.aeristas);
                  // for (Aeristas aerista in AeristasViewModel.arrayAeristas) {
                  //   print(aerista.id.toString()+': '+aerista.nombre_aerista);
                  // }
                  return AeristasViewModel.aeristas;
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text(suggestion),
                    
                  );
                },
                transitionBuilder: (context, suggestionsBox, controller) {
                  return suggestionsBox;
                },
                onSuggestionSelected: (suggestion) {
                  this.inputAeristaController.text = suggestion;
                  for (Aeristas aerista in AeristasViewModel.arrayAeristas) {
                    if(inputAeristaController.text == aerista.nombre_aerista){
                      idAerista = aerista.id;
                    }
                  }
                },
                validator: (value) {
                  if(idAerista == 0){
                    return 'Por favor, escoja un aerista';
                  }
                  if (value.isEmpty) {
                    return 'Por favor, escoja un aerista';
                  }
                },
                // onSaved: (value) => this.selectedAerista = value
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
              ),
              TextFormField(
                controller: numeroViajeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  // hintText: 'posible dropdown',
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
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Text("Mini Fincas:"),
                    FutureBuilder<List<MiniFincas>>(
                future: _fetchMiniFincas(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<MiniFincas>> snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  return new DropdownButton<MiniFincas>(
                    items: snapshot.data
                        .map((miniFinca) => DropdownMenuItem<MiniFincas>(
                              child: Text(miniFinca.nombre_mini_finca),
                              value: miniFinca,
                            ))
                        .toList(),
                    onChanged: (MiniFincas value) {
                      setState(() {
                        _currentMiniFinca = value;
                      });
                    },
                    isExpanded: true,
                    //value: _currentMiniFinca,
                    hint: _currentMiniFinca == null ? Text("Seleccione una mini finca") : Text(_currentMiniFinca.nombre_mini_finca),
                  );
                }),
                    // new DropdownButton(
                    //   value: _selectedMiniFinca,
                    //   items: _dropDownMenuItemsMiniFincas,
                    //   isExpanded: true,
                    //   onChanged: changedDropDownItemMiniFincsa,
                    // )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 15.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Text("Secciones:"),
                    FutureBuilder<List<SeccionMiniFinca>>(
                future: _fetchSeccionMiniFincas(_currentMiniFinca == null ? '1' : _currentMiniFinca.id.toString()),
                builder: (BuildContext context,
                    AsyncSnapshot<List<SeccionMiniFinca>> snapshot) {
                      switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                return new DropdownButton<SeccionMiniFinca>(
                    items: snapshot.data
                        .map((seccion) => DropdownMenuItem<SeccionMiniFinca>(
                              child: Text(seccion.seccion_mini_finca),
                              value: seccion,
                            ))
                        .toList(),
                    onChanged: (SeccionMiniFinca value) {
                      setState(() {
                        _currentSeccionMiniFinca = value;
                      });
                    },
                    isExpanded: true,
                    //value: _currentMiniFinca,
                    hint: _currentSeccionMiniFinca== null ? Text("Seleccione una seccion") : Text(_currentSeccionMiniFinca.seccion_mini_finca)
                  );
                }}),
                    // new DropdownButton(
                    //   value: _selectedMiniFincaSeccion,
                    //   items: _dropDownMenuItemsMiniFincasSecciones,
                    //   isExpanded: true,
                    //   onChanged: changedDropDownItemMiniFincsaSecciones,
                    // )
                  ],
                ),
              ),
              Container(
                //regresar aqui
                child: TextField(
                  controller: horaAereoController,
                  decoration: InputDecoration(labelText: "Hora"),
                  onTap: () {
                    print("tocado");
                    DatePicker.showTimePicker(context, showTitleActions: true,
                        onChanged: (date) {
                      print('change $date in time zone ' +
                          date.timeZoneOffset.inHours.toString());
                    }, onConfirm: (date) {
                      // print('confirm $date');
                      horaSeleccionada = date.toString();
                      String hora = formatDate(date, [hh, ':', nn, ' ', am]);
                      horaAereoController.text = hora;
                    }, currentTime: DateTime.now());
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
                    print("el id del aerista es: " + idAerista.toString());
                    if (_formKey.currentState.validate()) {
                      // print("enviando al server");

                      // ViajeAereo nuevoViaje = new ViajeAereo(
                      //     numero_viaje: numeroViajeController.text,
                      //     aerista: idAerista.toString(),
                      //     created_at: horaSeleccionada,
                      //     // mini_finca: _selectedMiniFinca,
                      //     seccion_mini_finca: _currentSeccionMiniFinca.id.toString(),
                      //     amarillo: conteoCintaAmarilla.toString(),
                      //     negro: conteoCintaNegra.toString(),
                      //     rojo: conteoCintaRoja.toString(),
                      //     verde: conteoCintaVerde.toString(),
                      //     morado: conteoCintaMorada.toString(),
                      //     cafe: conteoCintaCafe.toString(),
                      //     naranja: conteoCintaNaranja.toString(),
                      //     azul: conteoCintaAzul.toString());

                      // createViajeAereo(urlApiServer, body: nuevoViaje.toMap());
                    }
                  },
                ),
                margin: EdgeInsets.all(20.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
