

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:pasanaku/models/partida.dart';
import 'package:pasanaku/models/subasta.dart';
import 'package:pasanaku/providers/juego_provider.dart';

import '../../../models/juego.dart';
import '../../../models/user.dart';
import '../../../providers/partida_provider.dart';
import '../../shared/widgets/shared_pref.dart';

class ShowJuegoController{

  BuildContext? context;
  SharedPref _sharedPref = SharedPref();
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  Function? refresh;
  User? user;
  PartidaProvider _partidaProvider = PartidaProvider();
  List<Juego> jugadores = [];
  Partida? partida;
  Subasta? subasta;
  
  bool? estado;


  Future? init(BuildContext context, Function refresh, int idPartida) async{
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    this.estado = true;
    getPartida(idPartida);
    
    
  }

  void getPartida(int? id) async{
    
    print("id de invitado: $id");
    partida = (await _partidaProvider.partidas(id));
    print('psrtida controller');
    print(partida);
    //if (estado == true){
      refresh!();
      //estado = false;
    //}
    //
  } 


  void getRonda(int? id) async{
    print("id de la subasta");
    subasta = (await _partidaProvider.subasta(id));
    print("subasta desde el controlador");
    print(subasta);


  
  }

  /*Future<Partida?> getJueg(int? id) async {
    Partida? part = await _partidaProvider.partidas(id);
    print('partida controlador');
    print(part?.nombre);
    return part;
  }*/

}