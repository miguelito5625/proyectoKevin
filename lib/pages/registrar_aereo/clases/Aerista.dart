import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/services.dart';

class Aeristas {
  String nombre_aerista;

  Aeristas({
    this.nombre_aerista
  });

  factory Aeristas.fromJson(Map<String, dynamic> parsedJson) {
    return Aeristas(
        nombre_aerista: parsedJson['nombre_aerista'] as String
    );
  }
}

class AeristasViewModel {
  static List<Aeristas> aeristas;

  static Future loadAeristas() async {
    try {
      aeristas = new List<Aeristas>();
      final jsonString = await http.get("http://192.168.1.9:3000/listaeristas");
      Map parsedJson = json.decode(jsonString.body);
      var aeristasJson = parsedJson['Aeristas'] as List;
      for (int i = 0; i < aeristasJson.length; i++) {
        aeristas.add(new Aeristas.fromJson(aeristasJson[i]));
        print(Aeristas.fromJson(aeristasJson[i]));
      }
    } catch (e) {
      print(e);
    }
  }
}