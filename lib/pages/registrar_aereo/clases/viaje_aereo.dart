class ViajeAereo {
  final String numero_viaje;
  final String aerista;
  final String created_at;
  final String mini_finca;
  final String seccion_mini_finca;
  final String amarillo;
  final String negro;
  final String rojo;
  final String verde;
  final String morado;
  final String cafe;
  final String naranja;
  final String azul;


  ViajeAereo({this.numero_viaje,this.aerista, this.created_at, this.mini_finca, this.seccion_mini_finca, this.amarillo, this.negro,
  this.rojo, this.verde, this.morado, this.cafe, this.naranja, this.azul});

  factory ViajeAereo.fromJson(Map<String, dynamic> json) {
    return ViajeAereo(
      numero_viaje: json['numero_viaje'],
      aerista: json['aerista'],
      created_at: json['created_at'],
      mini_finca: json['mini_finca'],
      seccion_mini_finca: json['seccion_mini_finca'],
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
    map["aerista"] = aerista;
    map["created_at"] = created_at;
    map["mini_finca"] = mini_finca;
    map["seccion_mini_finca"] = seccion_mini_finca;
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
