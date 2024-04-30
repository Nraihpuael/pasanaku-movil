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
  }


  void getTransacciones(int? id) async{
    
    print("id de invitado: $id");
    transaccion = (await _transaccionProvider.transacciones(id))!;
    print('transaccion controller');
    print(transaccion);
    //if (estado == true){
      refresh!();
      //estado = false;
    //}
    //
  } 
}
