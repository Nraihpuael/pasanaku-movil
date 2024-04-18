import 'package:flutter/material.dart';
import 'package:pasanaku/models/invitacion.dart';
import 'package:pasanaku/models/user.dart';

import '../../../providers/invitacion_provider.dart';
import '../../shared/widgets/shared_pref.dart';

class InvitacionesPendientesController{

  BuildContext? context;
  
  SharedPref _sharedPref = SharedPref();
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  Function? refresh;
  User? user;
  InvitacionProvider _invitacionProvider = InvitacionProvider();
  List<Invitacion> invitaciones = [];

  Future? init(BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    getInvitaciones(user!.id);
    
  }

  void getInvitaciones(int? id) async{
    print("id de invitado: $id");
    invitaciones = (await _invitacionProvider.invitaciones(id))!;
    print(invitaciones);
    refresh!();
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