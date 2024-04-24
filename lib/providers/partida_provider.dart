


import 'dart:convert';


import 'package:pasanaku/models/partida.dart';

import '../config/constant/environment.dart';
import 'package:http/http.dart' as http;


class PartidaProvider{
  final String _url = Environment.API_DELIVERY;
  final String _api = '/api/partida';

  Future<Partida?> partidas(int? id)async{
    try {
      Uri url = Uri.http(_url, '$_api/$id');
      final res = await http.get(url);
      print(res.body);
      final data = json.decode(res.body);
      print("pasooo pero la dats esra haci");
      print(data);
      Partida partida = Partida.fromJson(data['data']);
      print(partida.id);
      //print("${invitacion.id}, ${invitacion.jugadorNombre}, ${invitacion.partidaFecha}");
      return partida;
    } catch (e) {
      print("error $e");
      return null;
    }
    
  }

}