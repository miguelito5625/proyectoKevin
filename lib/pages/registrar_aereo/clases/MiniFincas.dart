// import 'dart:convert';
// import 'package:http/http.dart' as http;

// //Clase para las minifincas
// class MiniFincas{

// int id;
// String nombre_mini_finca;

// MiniFincas({this.id, this.nombre_mini_finca});

// factory MiniFincas.fromJson(Map<String, dynamic> parsedJson) {
//     return MiniFincas(
//         id: parsedJson['id'] as int,
//         nombre_mini_finca: parsedJson['nombre_mini_finca'] as String
//     );
//   }

// }


// class MiniFincaViewModel {
//   // static List miniFincas;
//   static var arrayMiniFincas = [];

//   static Future loadMiniFincas() async {
//     try {
//       // miniFincas = new List<String>();
//       arrayMiniFincas = [];
//       final jsonString = await http.get("http://192.168.1.9:3000/minifincas/list");
//       Map parsedJson = json.decode(jsonString.body);
//       var miniFincasJson = parsedJson['miniFincas'] as List;
//       for (int i = 0; i < miniFincasJson.length; i++) {
//         int id = new MiniFincas.fromJson(miniFincasJson[i]).id;
//         String nombre_mini_finca = new MiniFincas.fromJson(miniFincasJson[i]).nombre_mini_finca;
//         // miniFincas.add(nombre_mini_finca);
//         arrayMiniFincas.add(new MiniFincas(id: id, nombre_mini_finca: nombre_mini_finca));
//         // print(MiniFincas.fromJson(miniFincasJson[i]));
//       }
//     } catch (e) {
//       print(e);
//     }

//   }
// }







class MiniFincas {
  int id;
  String nombre_mini_finca;

  MiniFincas({this.id, this.nombre_mini_finca});

  factory MiniFincas.fromJson(Map<String, dynamic> parsedJson){
    return MiniFincas(
      id: parsedJson['id'],
      nombre_mini_finca: parsedJson['nombre_mini_finca']
    );
  }

}


// final arrayMiniFincas = [
//     new MiniFincas("Mini 1"),
//     new MiniFincas("Mini 2"),
//     new MiniFincas("Mini 3"),
//     new MiniFincas("Mini 4"),
//     new MiniFincas("Mini 5"),
//     new MiniFincas("Mini 6"),
//     new MiniFincas("Mini 7"),
//     new MiniFincas("Mini 8"),
//   ];