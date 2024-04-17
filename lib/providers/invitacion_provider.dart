import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../config/constant/environment.dart';
import '../models/invitacion.dart';


class InvitacionProvider{

  String _url = Environment.API_DELIVERY;
  String _api = '/api/invitacion/invitaciones';

  
  Future<List<Invitacion>?> invitaciones(int? id)async{
    try {
      Uri url = Uri.http(_url, '$_api/$id');
      final res = await http.get(url);
      //para verificar estado
      //if (res.statusCode == 200){
        //
      //}

      final data = json.decode(res.body);
      Invitacion invitacion = Invitacion.fromJsonList(data);
      return invitacion.toList;
    } catch (e) {
      print("error $e");
      return null;
    }
  } 
}