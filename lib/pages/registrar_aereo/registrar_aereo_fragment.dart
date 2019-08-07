import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:date_format/date_format.dart';
import 'clases/SeccionMiniFinca.dart';
import 'clases/MiniFincas.dart';
import 'package:http/http.dart' as http;
// import 'widgets_registrar_aereos.dart';
import 'clases/viaje_aereo.dart';
import 'clases/Aerista.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';


class RegistrarAereo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new RegistrarAereoState();
  }
}

class RegistrarAereoState extends State<RegistrarAereo> {
  static final urlApiServer = 'http://192.168.1.9:3000/add';
  final _formKey = GlobalKey<FormState>();

  GlobalKey<AutoCompleteTextFieldState<Aeristas>> key = new GlobalKey();

  AutoCompleteTextField searchTextField;
  // TextEditingController controller = new TextEditingController();
  RegistrarAereoState();

  void _loadData() async {
    await AeristasViewModel.loadAeristas();
  }

  TextEditingController nombreAeristaController = new TextEditingController();
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

  List<DropdownMenuItem<String>> _dropDownMenuItemsMiniFincas;
  List<DropdownMenuItem<String>> _dropDownMenuItemsMiniFincasSecciones;
  String _selectedMiniFinca;
  String _selectedMiniFincaSeccion;

  List<DropdownMenuItem<String>> buildAndGetDropDownMenuItemsMiniFincas(
      List miniFincas) {
    List<DropdownMenuItem<String>> items = new List();
    for (MiniFincas miniFinca in miniFincas) {
      items.add(DropdownMenuItem(
          value: miniFinca.miniFinca, child: Text(miniFinca.miniFinca)));
    }
    return items;
  }

  void changedDropDownItemMiniFincsa(String selectedMiniFinca) {
    setState(() {
      _selectedMiniFinca = selectedMiniFinca;
      _dropDownMenuItemsMiniFincasSecciones =
          buildAndGetDropDownMenuItemsMiniFincasSecciones(
              arraySeccionMiniFincas);
      _selectedMiniFincaSeccion =
          _dropDownMenuItemsMiniFincasSecciones[0].value;
    });
  }

  List<DropdownMenuItem<String>>
      buildAndGetDropDownMenuItemsMiniFincasSecciones(List secciones) {
    List<DropdownMenuItem<String>> items = new List();
    for (SeccionMiniFinca seccion in secciones) {
      if (seccion.miniFinca == _selectedMiniFinca) {
        items.add(DropdownMenuItem(
            value: seccion.seccion, child: Text(seccion.seccion)));
      }
    }
    return items;
  }

  void changedDropDownItemMiniFincsaSecciones(String selectedMiniFincaSeccion) {
    setState(() {
      _selectedMiniFincaSeccion = selectedMiniFincaSeccion;
    });
  }


  Future<void> createViajeAereo(String url, {Map body}) async {

    try {
      var client = http.Client();
      var response = await client.post(Uri.encodeFull(url), body: body).whenComplete(() {
      client.close();
    });
    print(response.body);

    } catch (e) {

      print("ocurrio un error: " + e.toString());
    }

    // print("enviado");
    
  }
  

  @override
  void initState() {
    super.initState();
    _loadData();
    countCintaAmarillaController.text = conteoCintaAmarilla.toString();
    countCintaNegraController.text = conteoCintaNegra.toString();
    countCintaRojaController.text = conteoCintaRoja.toString();
    countCintaVerdeController.text = conteoCintaVerde.toString();
    countCintaMoradaController.text = conteoCintaMorada.toString();
    countCintaCafeController.text = conteoCintaCafe.toString();
    countCintaNaranjaController.text = conteoCintaNaranja.toString();
    countCintaAzulController.text = conteoCintaAzul.toString();

    _dropDownMenuItemsMiniFincas =
        buildAndGetDropDownMenuItemsMiniFincas(arrayMiniFincas);
    _selectedMiniFinca = _dropDownMenuItemsMiniFincas[0].value;

    _dropDownMenuItemsMiniFincasSecciones =
        buildAndGetDropDownMenuItemsMiniFincasSecciones(arraySeccionMiniFincas);
    _selectedMiniFincaSeccion = _dropDownMenuItemsMiniFincasSecciones[0].value;

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

              Padding(
                padding: EdgeInsets.only(top: 10.0),
              ),
              searchTextField = AutoCompleteTextField<Aeristas>(
                controller: nombreAeristaController,
                style: new TextStyle(color: Colors.black, fontSize: 16.0),
                decoration: new InputDecoration(
                    hintText: 'Aerista',
                    labelText: 'Aerista'
                    ),
                itemSubmitted: (item) {
                  setState(() => searchTextField.textField.controller.text =
                      item.nombre_aerista);
                },
                clearOnSubmit: false,
                key: key,
                suggestions: AeristasViewModel.aeristas,
                itemBuilder: (context, item) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(item.nombre_aerista,
                      style: TextStyle(
                        fontSize: 16.0
                      ),),
                    ],
                  );
                },
                itemSorter: (a, b) {
                  return a.nombre_aerista.compareTo(b.nombre_aerista);
                },
                itemFilter: (item, query) {
                  return item.nombre_aerista
                      .toLowerCase()
                      .startsWith(query.toLowerCase());
                }),

              Container(
                padding: EdgeInsets.only(top: 15.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Text("Mini Fincas:"),
                    new DropdownButton(
                      value: _selectedMiniFinca,
                      items: _dropDownMenuItemsMiniFincas,
                      isExpanded: true,
                      onChanged: changedDropDownItemMiniFincsa,
                    )
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
                    new DropdownButton(
                      value: _selectedMiniFincaSeccion,
                      items: _dropDownMenuItemsMiniFincasSecciones,
                      isExpanded: true,
                      onChanged: changedDropDownItemMiniFincsaSecciones,
                    )
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


              Container(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 10.0, left: 10.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 60.0,
                            width: screenSize.width * 0.25,
                            child: RaisedButton(
                              color: Colors.yellow,
                              child: Text(
                                'Amarillo',
                                style: TextStyle(color: Colors.white, fontSize: 12.0),
                              ),
                              onPressed: () {
                                if (num.tryParse(
                                        countCintaAmarillaController.text) ==
                                    null) {
                                  countCintaAmarillaController.text = "0";
                                  conteoCintaAmarilla = 0;
                                } else {
                                  setState(() {
                                    conteoCintaAmarilla = int.parse(
                                            countCintaAmarillaController.text) +
                                        1;
                                  });
                                  countCintaAmarillaController.text =
                                      conteoCintaAmarilla.toString();
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0, left: 10.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 60.0,
                            width: screenSize.width * 0.25,
                            child: RaisedButton(
                              color: Colors.black,
                              child: Text(
                                'Negro',
                                style: TextStyle(color: Colors.white, fontSize: 12.0),
                              ),
                              onPressed: () {
                                if (num.tryParse(
                                        countCintaNegraController.text) ==
                                    null) {
                                  countCintaNegraController.text = "0";
                                  conteoCintaNegra = 0;
                                } else {
                                  setState(() {
                                    conteoCintaNegra = int.parse(
                                            countCintaNegraController.text) +
                                        1;
                                  });
                                  countCintaNegraController.text =
                                      conteoCintaNegra.toString();
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0, left: 10.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 60.0,
                            width: screenSize.width * 0.25,
                            child: RaisedButton(
                              color: Colors.red,
                              child: Text(
                                'Rojo',
                                style: TextStyle(color: Colors.white, fontSize: 12.0),
                              ),
                              onPressed: () {
                                if (num.tryParse(
                                        countCintaRojaController.text) ==
                                    null) {
                                  countCintaRojaController.text = "0";
                                  conteoCintaRoja = 0;
                                } else {
                                  setState(() {
                                    conteoCintaRoja = int.parse(
                                            countCintaRojaController.text) +
                                        1;
                                  });
                                  countCintaRojaController.text =
                                      conteoCintaRoja.toString();
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 10.0, left: 10.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 60.0,
                            width: screenSize.width * 0.25,
                            child: RaisedButton(
                              color: Colors.green,
                              child: Text(
                                'Verde',
                                style: TextStyle(color: Colors.white, fontSize: 12.0),
                              ),
                              onPressed: () {
                                if (num.tryParse(
                                        countCintaVerdeController.text) ==
                                    null) {
                                  countCintaVerdeController.text = "0";
                                  conteoCintaVerde = 0;
                                } else {
                                  setState(() {
                                    conteoCintaVerde = int.parse(
                                            countCintaVerdeController.text) +
                                        1;
                                  });
                                  countCintaVerdeController.text =
                                      conteoCintaVerde.toString();
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0, left: 10.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 60.0,
                            width: screenSize.width * 0.25,
                            child: RaisedButton(
                              color: Colors.purple,
                              child: Text(
                                'Morado',
                                style: TextStyle(color: Colors.white, fontSize: 12.0),
                              ),
                              onPressed: () {
                                if (num.tryParse(
                                        countCintaMoradaController.text) ==
                                    null) {
                                  countCintaMoradaController.text = "0";
                                  conteoCintaMorada = 0;
                                } else {
                                  setState(() {
                                    conteoCintaMorada = int.parse(
                                            countCintaMoradaController.text) +
                                        1;
                                  });
                                  countCintaMoradaController.text =
                                      conteoCintaMorada.toString();
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0, left: 10.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 60.0,
                            width: screenSize.width * 0.25,
                            child: RaisedButton(
                              color: Color(0xFF4B3621),
                              child: Text(
                                'Café',
                                style: TextStyle(color: Colors.white, fontSize: 12.0),
                              ),
                              onPressed: () {
                                if (num.tryParse(
                                        countCintaCafeController.text) ==
                                    null) {
                                  countCintaCafeController.text = "0";
                                  conteoCintaCafe = 0;
                                } else {
                                  setState(() {
                                    conteoCintaCafe = int.parse(
                                            countCintaCafeController.text) +
                                        1;
                                  });
                                  countCintaCafeController.text =
                                      conteoCintaCafe.toString();
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 10.0, left: 10.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 60.0,
                            width: screenSize.width * 0.25,
                            child: RaisedButton(
                              color: Colors.orange,
                              child: Text(
                                'Naranja',
                                style: TextStyle(color: Colors.white, fontSize: 12.0),
                              ),
                              onPressed: () {
                                if (num.tryParse(
                                        countCintaNaranjaController.text) ==
                                    null) {
                                  countCintaNaranjaController.text = "0";
                                  conteoCintaNaranja = 0;
                                } else {
                                  setState(() {
                                    conteoCintaNaranja = int.parse(
                                            countCintaNaranjaController.text) +
                                        1;
                                  });
                                  countCintaNaranjaController.text =
                                      conteoCintaNaranja.toString();
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0, left: 10.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 60.0,
                            width: screenSize.width * 0.25,
                            child: RaisedButton(
                              color: Colors.blue,
                              child: Text(
                                'Azul',
                                style: TextStyle(color: Colors.white, fontSize: 12.0),
                              ),
                              onPressed: () {
                                if (num.tryParse(
                                        countCintaAzulController.text) ==
                                    null) {
                                  countCintaAzulController.text = "0";
                                  conteoCintaAzul = 0;
                                } else {
                                  setState(() {
                                    conteoCintaAzul = int.parse(
                                            countCintaAzulController.text) +
                                        1;
                                  });
                                  countCintaAzulController.text =
                                      conteoCintaAzul.toString();
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),



              TextFormField(
                keyboardType: TextInputType.number,
                controller: countCintaAmarillaController,
                decoration: InputDecoration(
                  // hintText: 'posible dropdown',
                  labelText: 'Amarillo',
                ),
                validator: (value) {
                  if (value.isEmpty || num.tryParse(value) == null) {
                    return 'ingrese un numero o deje en 0';
                  }
                }, //regresar
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: countCintaNegraController,
                decoration: InputDecoration(
                  // hintText: 'posible dropdown',
                  labelText: 'Negro',
                ),
                validator: (value) {
                  if (value.isEmpty || num.tryParse(value) == null) {
                    return 'ingrese un numero o deje en 0';
                  }
                }, //regresar
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: countCintaRojaController,
                decoration: InputDecoration(
                  // hintText: 'posible dropdown',
                  labelText: 'Rojo',
                ),
                validator: (value) {
                  if (value.isEmpty || num.tryParse(value) == null) {
                    return 'ingrese un numero o deje en 0';
                  }
                }, //regresar
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: countCintaVerdeController,
                decoration: InputDecoration(
                  // hintText: 'posible dropdown',
                  labelText: 'Verde',
                ),
                validator: (value) {
                  if (value.isEmpty || num.tryParse(value) == null) {
                    return 'ingrese un numero o deje en 0';
                  }
                }, //regresar
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: countCintaMoradaController,
                decoration: InputDecoration(
                  // hintText: 'posible dropdown',
                  labelText: 'Morado',
                ),
                validator: (value) {
                  if (value.isEmpty || num.tryParse(value) == null) {
                    return 'ingrese un numero o deje en 0';
                  }
                }, //regresar
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: countCintaCafeController,
                decoration: InputDecoration(
                  // hintText: 'posible dropdown',
                  labelText: 'Café',
                ),
                validator: (value) {
                  if (value.isEmpty || num.tryParse(value) == null) {
                    return 'ingrese un numero o deje en 0';
                  }
                }, //regresar
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: countCintaNaranjaController,
                decoration: InputDecoration(
                  // hintText: 'posible dropdown',
                  labelText: 'Naranja',
                ),
                validator: (value) {
                  if (value.isEmpty || num.tryParse(value) == null) {
                    return 'ingrese un numero o deje en 0';
                  }
                }, //regresar
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: countCintaAzulController,
                decoration: InputDecoration(
                  // hintText: 'posible dropdown',
                  labelText: 'Azul',
                ),
                validator: (value) {
                  if (value.isEmpty || num.tryParse(value) == null) {
                    return 'ingrese un numero o deje en 0';
                  }
                }, //regresar
              ),
              Container(
                width: screenSize.width,
                child: RaisedButton(
                  color: Colors.blue,
                  child: Text(
                    'Guardar',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      // print("enviando al server");

                      ViajeAereo nuevoViaje =  new ViajeAereo(
                        numero_viaje: numeroViajeController.text,
                        aerista: nombreAeristaController.text,
                        created_at: horaSeleccionada,
                        mini_finca: _selectedMiniFinca,
                        seccion_mini_finca: _selectedMiniFincaSeccion,
                        amarillo: conteoCintaAmarilla.toString(),
                        negro: conteoCintaNegra.toString(),
                        rojo: conteoCintaRoja.toString(),
                        verde: conteoCintaVerde.toString(),
                        morado: conteoCintaMorada.toString(),
                        cafe: conteoCintaCafe.toString(),
                        naranja: conteoCintaNaranja.toString(),
                        azul: conteoCintaAzul.toString()
                      );

                      createViajeAereo(urlApiServer, body: nuevoViaje.toMap());

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
