import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pasanaku/config/constant/environment.dart';
import 'package:pasanaku/models/notificacion.dart';
import 'package:http/http.dart' as http;

class NotificacionProvider{

  final String _url = Environment.API_DELIVERY;
  final String _api = '/api/notification';

  Future<List<Notificacion>?> transacciones(int? id)async{
    try {
      Uri url = Uri.https(_url, '$_api/$id');
      final res = await http.get(url);
      final data = json.decode(res.body);
      Notificacion notificacion = Notificacion.fromJsonList(data);
      
      return notificacion.toList;
    } catch (e) {
      print("error $e");
      return null;
    }
    
  }

}