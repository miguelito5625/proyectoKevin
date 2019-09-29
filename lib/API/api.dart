import 'dart:async';
import 'package:http/http.dart' as http;

const baseUrl = "http://35.226.107.150:3000";

class API {

  static Future todosLosViajes(){
    var url = baseUrl + "/aereos/mostrartodos";
    return http.get(url);
  }

}