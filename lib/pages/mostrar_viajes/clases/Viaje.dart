

import 'dart:convert';

class Viaje {

  int id;
  int numeroViaje;
  String nombreAerista;
  

  Viaje({this.id, this.numeroViaje, this.nombreAerista});


  Viaje.fromJson(Map json)
    : id = json['id'],
      numeroViaje = json['numeroViaje'],
      nombreAerista = json['nombreAerista'];

  Map toJson(){
    return {
            'id': id,
            'numeroViaje' : numeroViaje,
            'nombreAerista': nombreAerista
          };
  }

  
}