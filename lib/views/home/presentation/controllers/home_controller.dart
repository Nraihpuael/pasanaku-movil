import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pasanaku/models/invitacion.dart';
import 'package:pasanaku/models/models.dart';
import 'package:pasanaku/providers/invitacion_provider.dart';
import 'package:pasanaku/views/shared/widgets/shared_pref.dart';

class HomeController{
  BuildContext? context;
  
  SharedPref _sharedPref = SharedPref();
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  Function? refresh;
  User? user;
  InvitacionProvider _invitacionProvider = InvitacionProvider();
  
  List<Invitacion>? invitaciones = [];
  Future? init(BuildContext context, Function refresh) async{
    
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    getInvitaciones(user!.id);
    
  }

  
  void getInvitaciones(int? id) async{
    //print("id de invitado: $id");
    // invitaciones = (await _invitacionProvider.invitaciones(id))!;
    //print("controller impr");
    //print(invitaciones[0].jugadorNombre);
    // refresh!();   
    try {
    print("id de invitado: $id");
    
    invitaciones = await _invitacionProvider.invitaciones(id);

    if (invitaciones == null ) {
      print("No hay invitaciones para el ID: $id");
      invitaciones = [];
    } else {
      invitaciones = invitaciones;
    }

    // Llama a refresh solo si no es nulo
    if (refresh != null) {
      refresh!();
    }

  } catch (e) {
    print("Error al obtener invitaciones: $e");
    // Manejar el error según sea necesario, puedes mostrar un mensaje al usuario
  }

  }

  void logout(){
    _sharedPref.logout(context!);
  }

  Future<List<Invitacion>?> obtenrInvitaciones() async{
    return await _invitacionProvider.invitaciones(43);
  }


  void openDrawer(){
    key.currentState!.openDrawer();
  }

  

}