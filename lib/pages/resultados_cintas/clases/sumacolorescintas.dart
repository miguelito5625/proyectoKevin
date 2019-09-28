class SumaColoresCintas {

  int amarillo;
  int negro;
  int rojo;
  int verde;
  int morado;
  int cafe;
  int naranja;
  int azul;
  String fecha;

  SumaColoresCintas({this.amarillo, this.negro, this.rojo, this.verde, this.morado, this.cafe, this.naranja,
  this.azul, this.fecha});

  SumaColoresCintas.fromJson(Map json)
    : amarillo = json['amarillo'],
      negro = json['negro'],
      rojo = json['rojo'],
      verde = json['verde'],
      morado = json['morado'],
      cafe = json['cafe'],
      naranja = json['naranja'],
      azul = json['azul'],
      fecha = json['fecha'];


      Map toJson(){
    return {
            'amarillo': amarillo,
            'negro': negro,
            'rojo': rojo,
            'verde': verde,
            'morado': morado,
            'cafe': cafe,
            'naranja': naranja,
            'azul': azul,
            'fecha': fecha
          };
  }


}
