

import 'dart:convert';


import '../config/constant/environment.dart';
import 'package:http/http.dart' as http;
import '../models/juego.dart';

class JuegoProvider{
  final String _url = Environment.API_DELIVERY;
  final String _api = '/api/jugadores';

  Future<List<Juego>?> juegos(int? id)async{
    try {
      Uri url = Uri.http(_url, '$_api/$id/participaciones');
      final res = await http.get(url);
      print(res.body);
      final data = json.decode(res.body);
      print("pasooo pero la dats esra haci");
      print(data['data']);
      Juego juego = Juego.fromJsonList(data['data']);
      print(juego.partida?.moneda);
      //print("${invitacion.id}, ${invitacion.jugadorNombre}, ${invitacion.partidaFecha}");
      return juego.toList;
    } catch (e) {
      print("error $e");
      return null;
    }
    
  }

}