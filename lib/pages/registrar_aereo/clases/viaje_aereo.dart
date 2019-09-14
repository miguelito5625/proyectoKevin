class ViajeAereo {
  final String numero_viaje;
  final String id_aerista;
  final String created_at;
  final String id_mini_finca;
  final String id_seccion_mini_finca;
  final String amarillo;
  final String negro;
  final String rojo;
  final String verde;
  final String morado;
  final String cafe;
  final String naranja;
  final String azul;


  ViajeAereo({this.numero_viaje,this.id_aerista, this.created_at, this.id_mini_finca, this.id_seccion_mini_finca, this.amarillo, this.negro,
  this.rojo, this.verde, this.morado, this.cafe, this.naranja, this.azul});

  factory ViajeAereo.fromJson(Map<String, dynamic> json) {
    return ViajeAereo(
      numero_viaje: json['numero_viaje'],
      id_aerista: json['id_aerista'],
      created_at: json['created_at'],
      id_mini_finca: json['id_mini_finca'],
      id_seccion_mini_finca: json['id_seccion_mini_finca'],
      amarillo: json['amarillo'],
      negro: json['negro'],
      rojo: json['rojo'],
      verde: json['verde'],
      morado: json['morado'],
      cafe: json['cafe'],
      naranja: json['naranja'],
      azul: json['azul'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["numero_viaje"] = numero_viaje;
    map["id_aerista"] = id_aerista;
    map["created_at"] = created_at;
    map["id_mini_finca"] = id_mini_finca;
    map["id_seccion_mini_finca"] = id_seccion_mini_finca;
    map["amarillo"] = amarillo;
    map["negro"] = negro;
    map["rojo"] = rojo;
    map["verde"] = verde;
    map["morado"] = morado;
    map["cafe"] = cafe;
    map["naranja"] = naranja;
    map["azul"] = azul;

    return map;
  }
}
