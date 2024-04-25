

import 'dart:convert';

import 'package:flutter/material.dart';

import '../config/constant/environment.dart';
import 'package:http/http.dart' as http;

class OfertaProvider{
  String _url = Environment.API_DELIVERY;
  String _api = '/api/oferta';


  BuildContext? context;

  // ignore: body_might_complete_normally_nullable
  Future? init(BuildContext context) {
    this.context = context;
  }


  Future<void> enviarPuja(int jugadorId, int subastaId, int puja) async{
    
    try {
      Uri uri = Uri.http(_url, _api);
      String bodyParams = json.encode({'puja': puja, 'subastaId': subastaId, 'jugadorId': jugadorId});
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      final res = await http.post(uri, headers: headers, body: bodyParams);
      final data = jsonDecode(res.body);
      //aqui hay que revisar que devuelve
      print(data);

    } catch (e) {
      print("error capturado: $e");

    }
    
  }


}
