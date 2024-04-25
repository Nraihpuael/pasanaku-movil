

import 'package:flutter/material.dart';
import 'package:pasanaku/models/models.dart';
import 'package:pasanaku/models/partida.dart';
import 'package:pasanaku/providers/juego_provider.dart';
import 'package:pasanaku/providers/oferta_provider.dart';
import 'package:pasanaku/providers/partida_provider.dart';
import 'package:pasanaku/views/shared/widgets/my_snackbar.dart';

import '../../../models/juego.dart';
import '../../../models/user.dart';
import '../../shared/widgets/shared_pref.dart';

class JuegosController{

  BuildContext? context;
  SharedPref _sharedPref = SharedPref();
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  Function? refresh;
  User? user;
  JuegoProvider _juegoProvider = JuegoProvider();
  PartidaProvider _partidaProvider = PartidaProvider();
  OfertaProvider _ofertaProvider = OfertaProvider();
  List<Juego> juegos = [];


  Future? init(BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    getJuegos(user!.id);
    
  }

  void getJuegos(int? id) async{
    print("id de invitado: $id");
    juegos = (await _juegoProvider.juegos(id))!;
    print(juegos);
    refresh!();
  } 


  void enviarPuja(int puja, int subastaId, int jugadorId) async{
    print("$puja, $subastaId, $jugadorId");
    ResponseApi? responseApi = await _ofertaProvider.enviarPuja(jugadorId, subastaId, puja);    
    if (responseApi!.message == "No se puede ingresar pujas a esta subasta"){
      MySnackbar.show(context!, "No se puede ingresar pujas");
    } else {
      MySnackbar.show(context!, "puja ingresada con exito");
    }
    
  }

  

}