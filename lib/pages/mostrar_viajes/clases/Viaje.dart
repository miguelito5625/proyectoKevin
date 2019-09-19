

import 'dart:convert';

class Viaje {

  int id;
  int numeroViaje;
  int idAerista;
  String nombreAerista;
  int idMiniFinca;
  String nombreMiniFinca;
  int idSeccionMiniFinca;
  String seccionMiniFinca;
  String createdAt;
  int amarillo;

  int negro;
  int rojo;
  int verde;
  int morado;
  int cafe;
  int naranja;
  int azul;
  

  Viaje({this.id, this.numeroViaje, this.idAerista, this.nombreAerista, this.idMiniFinca, this.nombreMiniFinca, this.idSeccionMiniFinca, this.seccionMiniFinca, this.createdAt, 
  this.amarillo, this.negro, this.rojo, this.verde, this.morado, this.cafe, this.naranja, this.azul});


  Viaje.fromJson(Map json)
    : id = json['id'],
      numeroViaje = json['numeroViaje'],
      idAerista = json['idAerista'],
      nombreAerista = json['nombreAerista'],
      idMiniFinca = json['idMiniFinca'],
      nombreMiniFinca =json['nombre_mini_finca'],
      idSeccionMiniFinca = json['idSeccionMiniFinca'],
      seccionMiniFinca = json['nombre_seccion_mini_finca'],
      createdAt = json['created_at'],
      amarillo = json['amarillo'],
      negro = json['negro'],
      rojo = json['rojo'],
      verde = json['verde'],
      morado = json['morado'],
      cafe = json['cafe'],
      naranja = json['naranja'],
      azul = json['azul'];

  Map toJson(){
    return {
            'id': id,
            'numeroViaje' : numeroViaje,
            'idAerista': idAerista,
            'nombreAerista': nombreAerista,
            'idMiniFinca': idMiniFinca,
            'nombreMiniFinca': nombreMiniFinca,
            'idSeccionMiniFinca': idSeccionMiniFinca,
            'seccionMiniFinca': seccionMiniFinca,
            'createdAt': createdAt,
            'amarillo': amarillo,
            'negro': negro,
            'rojo': rojo,
            'verde': verde,
            'morado': morado,
            'cafe': cafe,
            'naranja': naranja,
            'azul': azul
          };
  }

  
}