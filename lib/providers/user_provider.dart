import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:pasanaku/models/response_api.dart';

import '../config/config.dart';
import '../models/user.dart';

class UserProvider {
  String _url = Environment.API_DELIVERY;
  String _api = '/api/jugadores';

  BuildContext? context;

  // ignore: body_might_complete_normally_nullable
  Future? init(BuildContext context) {
    this.context = context;
  }

  ///respnde un responseapu
  Future<ResponseApi?> create(User user) async {
    try {
      Uri uri = Uri.https(_url, '$_api/register');
      String bodyParams = json.encode(user);
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      final res = await http.post(uri, headers: headers, body: bodyParams);

      print('Response status: ${res.statusCode}');
      print('Response body: ${res.body}');
      print('envio');

      final data = jsonDecode(res.body);

      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('error $e');
      return null;
    }
  }

  Future<ResponseApi?> login(String email, String password) async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    try {
      Uri uri = Uri.https(_url, '$_api/login');
      String bodyParams = json.encode(
          {'email': email, 'password': password, "tokenMovil": fcmToken});
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      final res = await http.post(uri, headers: headers, body: bodyParams);

      final data = jsonDecode(res.body);
      

      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('error $e');
      return null;
    }
  }
}
