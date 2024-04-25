


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
      print(data);
      Partida partida = Partida.fromJson(data);
      print('partida provider');
      print(partida);
      //print("${invitacion.id}, ${invitacion.jugadorNombre}, ${invitacion.partidaFecha}");
      return partida;
    } catch (e) {
      print("errorrr $e");
      return null;
    }
    
  }

}