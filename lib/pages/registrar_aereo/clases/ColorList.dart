import 'package:flutter/material.dart';

//Clase para crear lista de colores
class ColorsList {
  String nameColor;
  Color elColor;

  ColorsList(String nameColor, Color elColor) {
    this.nameColor = nameColor;
    this.elColor = elColor;
  }
}

final arrayColors = [
    new ColorsList("Amarillo", Colors.yellow),
    new ColorsList("Negro", Colors.black),
    new ColorsList("Rojo", Colors.red),
    new ColorsList("Verde", Colors.green),
    new ColorsList("Morado", Colors.purple),
    new ColorsList("Café", Color(0xFF4B3621)),
    new ColorsList("Naranja", Colors.orange),
    new ColorsList("Azul", Colors.blue),
  ];