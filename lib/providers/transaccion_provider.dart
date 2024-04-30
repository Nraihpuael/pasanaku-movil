import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pasanaku/config/constant/environment.dart';
import 'package:pasanaku/models/transaccion.dart';
import 'package:http/http.dart' as http;


class TransaccionProvider {

  final String _url = Environment.API_DELIVERY;
  final String _api = '/api/transferencia';


  Future<List<Transaccion>?> transacciones(int? id)async{
    try {
      Uri url = Uri.https(_url, '$_api/$id');
      final res = await http.get(url);
      final data = json.decode(res.body);
      Transaccion transaccion = Transaccion.fromJsonList(data);
      
      return transaccion.toList;
    } catch (e) {
      print("error $e");
      return null;
    }
    
  }




}