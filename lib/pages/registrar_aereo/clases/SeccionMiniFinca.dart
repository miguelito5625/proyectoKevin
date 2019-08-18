class SeccionMiniFinca {
  int id;
  String seccion_mini_finca;

  SeccionMiniFinca({this.id, this.seccion_mini_finca});

  factory SeccionMiniFinca.fromJson(Map<String, dynamic> parsedJson){
    return SeccionMiniFinca(
      id: parsedJson['id'],
      seccion_mini_finca: parsedJson['nombre_seccion_mini_finca']
    );
  }

}



//clase para las secciones de las minifincas
// class SeccionMiniFinca {
//   String miniFinca;
//   String seccion;

//   SeccionMiniFinca(String miniFinca, String seccion) {
//     this.miniFinca = miniFinca;
//     this.seccion = seccion;
//   }
// }


// final arraySeccionMiniFincas = [
//     new SeccionMiniFinca("Mini 1", "A1"),
//     new SeccionMiniFinca("Mini 1", "A2"),
//     new SeccionMiniFinca("Mini 1", "A3"),
//     new SeccionMiniFinca("Mini 1", "A4"),
//     new SeccionMiniFinca("Mini 1", "A5"),
//     new SeccionMiniFinca("Mini 1", "A6"),
//     new SeccionMiniFinca("Mini 1", "A7"),
//     new SeccionMiniFinca("Mini 1", "A8"),
//     new SeccionMiniFinca("Mini 2", "A8"),
//     new SeccionMiniFinca("Mini 2", "A9"),
//     new SeccionMiniFinca("Mini 2", "A10"),
//     new SeccionMiniFinca("Mini 2", "A11"),
//     new SeccionMiniFinca("Mini 2", "A12"),
//     new SeccionMiniFinca("Mini 2", "A13"),
//     new SeccionMiniFinca("Mini 2", "A14"),
//     new SeccionMiniFinca("Mini 2", "A15"),
//     new SeccionMiniFinca("Mini 3", "A16"),
//     new SeccionMiniFinca("Mini 3", "A17"),
//     new SeccionMiniFinca("Mini 3", "A18"),
//     new SeccionMiniFinca("Mini 3", "A19"),
//     new SeccionMiniFinca("Mini 3", "B14"),
//     new SeccionMiniFinca("Mini 3", "B15"),
//     new SeccionMiniFinca("Mini 3", "B16"),
//     new SeccionMiniFinca("Mini 3", "B17"),
//     new SeccionMiniFinca("Mini 3", "B18"),
//     new SeccionMiniFinca("Mini 4", "B7"),
//     new SeccionMiniFinca("Mini 4", "B8"),
//     new SeccionMiniFinca("Mini 4", "B9"),
//     new SeccionMiniFinca("Mini 4", "B10"),
//     new SeccionMiniFinca("Mini 4", "B11"),
//     new SeccionMiniFinca("Mini 4", "B12"),
//     new SeccionMiniFinca("Mini 4", "B13"),
//     new SeccionMiniFinca("Mini 4", "C12"),
//     new SeccionMiniFinca("Mini 4", "C13"),
//     new SeccionMiniFinca("Mini 5", "D8"),
//     new SeccionMiniFinca("Mini 5", "D9"),
//     new SeccionMiniFinca("Mini 5", "D10"),
//     new SeccionMiniFinca("Mini 5", "D11"),
//     new SeccionMiniFinca("Mini 5", "D12"),
//     new SeccionMiniFinca("Mini 5", "D13"),
//     new SeccionMiniFinca("Mini 5", "D14"),
//     new SeccionMiniFinca("Mini 5", "D15"),
//     new SeccionMiniFinca("Mini 5", "D16"),
//     new SeccionMiniFinca("Mini 6", "C13"),
//     new SeccionMiniFinca("Mini 6", "C14"),
//     new SeccionMiniFinca("Mini 6", "C15"),
//     new SeccionMiniFinca("Mini 6", "C16"),
//     new SeccionMiniFinca("Mini 6", "C17"),
//     new SeccionMiniFinca("Mini 6", "C18"),
//     new SeccionMiniFinca("Mini 6", "C19"),
//     new SeccionMiniFinca("Mini 7", "E2"),
//     new SeccionMiniFinca("Mini 7", "E3"),
//     new SeccionMiniFinca("Mini 7", "E4"),
//     new SeccionMiniFinca("Mini 7", "E5"),
//     new SeccionMiniFinca("Mini 7", "E6"),
//     new SeccionMiniFinca("Mini 7", "E7"),
//     new SeccionMiniFinca("Mini 7", "E8"),
//     new SeccionMiniFinca("Mini 7", "E9"),
//     new SeccionMiniFinca("Mini 7", "E10"),
//     new SeccionMiniFinca("Mini 7", "E11"),
//     new SeccionMiniFinca("Mini 7", "D7"),
//     new SeccionMiniFinca("Mini 8", "F1"),
//     new SeccionMiniFinca("Mini 8", "F2"),
//     new SeccionMiniFinca("Mini 8", "F3"),
//     new SeccionMiniFinca("Mini 8", "F4"),
//     new SeccionMiniFinca("Mini 8", "F5"),
//     new SeccionMiniFinca("Mini 8", "G1"),
//     new SeccionMiniFinca("Mini 8", "G2"),
//     new SeccionMiniFinca("Mini 8", "G3"),
//     new SeccionMiniFinca("Mini 8", "G4"),
//     new SeccionMiniFinca("Mini 8", "G5"),
//     new SeccionMiniFinca("Mini 8", "G6"),
//   ];