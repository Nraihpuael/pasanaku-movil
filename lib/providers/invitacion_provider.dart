import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/constant/environment.dart';
import '../models/invitacion.dart';


class InvitacionProvider{

  final String _url = Environment.API_DELIVERY;
  final String _api = '/api/invitacion';

  
  Future<List<Invitacion>?> invitaciones(int? id)async{
    try {
      Uri url = Uri.http(_url, '$_api/invitaciones/$id');
      final res = await http.get(url);
      final data = json.decode(res.body);
      Invitacion invitacion = Invitacion.fromJsonList(data);
      //print("imprimiendo invitacion");
      //print("${invitacion.id}, ${invitacion.jugadorNombre}, ${invitacion.partidaFecha}");
      return invitacion.toList;
    } catch (e) {
      print("error $e");
      return null;
    }
    
  } 

  Future<void> aceptarInvitacion(int idInvitacion) async{
    try {
      Uri url = Uri.http(_url, '$_api/aceptar/$idInvitacion');
      final res = await http.put(url);
      final data = json.decode(res.body);
      return data;
    } catch (e) {
      print("error $e");

      return;
    }

  }
  Future<void> rechazarInvitacion(int idInvitacion) async{
    try {
      Uri url = Uri.http(_url, '$_api/rechazar/$idInvitacion');
      final res = await http.put(url);
      final data = json.decode(res.body);
      return data;
    } catch (e) {
      print("error $e");
      return;
    }

  }
}