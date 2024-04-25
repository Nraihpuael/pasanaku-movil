


import 'dart:convert';


import 'package:pasanaku/models/partida.dart';
import 'package:pasanaku/models/subasta.dart';

import '../config/constant/environment.dart';
import 'package:http/http.dart' as http;


class PartidaProvider{
  final String _url = Environment.API_DELIVERY;
  final String _api = '/api';

  Future<Partida?> partidas(int? id)async{
    try {
      Uri url = Uri.http(_url, '$_api/partida/$id');
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
      print("errorrr de $e");
      return null;
    }
    
  }


  Future<Subasta?> subasta(int? id) async{
  
    try {
      Uri url = Uri.http(_url, '$_api/subasta/$id');
      final res = await http.get(url);
      print(res.body);
      final data = json.decode(res.body);
      print(data);
      Subasta subasta = Subasta.fromJson(data);
      print('subasta provider');
      print(subasta);
      //print("${invitacion.id}, ${invitacion.jugadorNombre}, ${invitacion.partidaFecha}");
      return subasta;
    } catch (e) {
      print("errorrr $e");
      return null;
    }
  }

}