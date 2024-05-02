import 'package:flutter/material.dart';
import 'package:pasanaku/models/notificacion.dart';
import 'package:pasanaku/models/user.dart';
import 'package:pasanaku/providers/notificacion_provider.dart';

import '../../shared/widgets/shared_pref.dart';


class NotificacionController{

  BuildContext? context;
  SharedPref _sharedPref = SharedPref();
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  Function? refresh;
  User? user;
  NotificacionProvider _notificacionProvider = NotificacionProvider();
  List<Notificacion> notificacion = [];

  Future? init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    getNotificaciones(user!.id);
    //refresh();
  }


  void getNotificaciones(int? id) async{
    
    try {
    print("id de invitado: $id");
    
    notificacion = (await _notificacionProvider.transacciones(id))!;

    if (notificacion == null ) {
      print("No hay invitaciones para el ID: $id");
      notificacion = [];
    } else {
      notificacion = notificacion;
    }

    // Llama a refresh solo si no es nulo
    if (refresh != null) {
      refresh!();
    }
    print("finalizo el get invitaciones>>>>>>>");
    } catch (e) {
      print("Error al obtener invitaciones: $e");
      // Manejar el error según sea necesario, puedes mostrar un mensaje al usuario
    }
  } 
}

