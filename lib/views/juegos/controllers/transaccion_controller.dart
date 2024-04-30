import 'package:flutter/material.dart';
import 'package:pasanaku/models/transaccion.dart';
import 'package:pasanaku/models/user.dart';
import 'package:pasanaku/providers/transaccion_provider.dart';
import 'package:pasanaku/views/shared/widgets/shared_pref.dart';

class TransaccionController {
  BuildContext? context;
  SharedPref _sharedPref = SharedPref();
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  Function? refresh;
  User? user;
  TransaccionProvider _transaccionProvider = TransaccionProvider();
  List<Transaccion> transaccion = [];
  

  Future? init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    getTransacciones(user!.id);
    //refresh();
  }


  void getTransacciones(int? id) async{
    
    try {
    print("id de invitado: $id");
    
    transaccion = (await _transaccionProvider.transacciones(id))!;

    if (transaccion == null ) {
      print("No hay invitaciones para el ID: $id");
      transaccion = [];
    } else {
      transaccion = transaccion;
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
