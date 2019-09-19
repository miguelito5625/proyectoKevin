import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../API/api.dart';

import 'package:flutter/services.dart';

class Aeristas {
  int id;
  String nombre_aerista;

  Aeristas({
    this.id,
    this.nombre_aerista
  });

  factory Aeristas.fromJson(Map<String, dynamic> parsedJson) {
    return Aeristas(
        nombre_aerista: parsedJson['nombre_aerista'] as String,
        id: parsedJson['id'] as int
    );
  }
}

class AeristasViewModel {
  static List aeristas;
  static var arrayAeristas = [];

  static Future loadAeristas(String filter) async {
    var map = new Map<String, dynamic>();
    map["filter"] = filter;
    try {
      aeristas = new List<String>();
      arrayAeristas = [];
      final jsonString = await http.post(baseUrl +"/aerista/listfilter", body: map);
      Map parsedJson = json.decode(jsonString.body);
      var aeristasJson = parsedJson['Aeristas'] as List;
      for (int i = 0; i < aeristasJson.length; i++) {
        int id = new Aeristas.fromJson(aeristasJson[i]).id;
        String nombre = new Aeristas.fromJson(aeristasJson[i]).nombre_aerista;
        aeristas.add(nombre);
        arrayAeristas.add(new Aeristas(id: id, nombre_aerista: nombre));
        print(Aeristas.fromJson(aeristasJson[i]));
      }
    } catch (e) {
      print(e);
    }
  }
}