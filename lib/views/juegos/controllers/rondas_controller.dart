import 'package:flutter/material.dart';

import '../../../models/subasta.dart';
import '../../../providers/partida_provider.dart';
import '../../shared/widgets/shared_pref.dart';



class RondaController{

  BuildContext? context;
  SharedPref _sharedPref = SharedPref();
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  Function? refresh;
  
  PartidaProvider _partidaProvider = PartidaProvider();
  
  
  Subasta? subasta;
  
  bool? estado;


  Future? init(BuildContext context, Function refresh, int idSubasta) async{
    this.context = context;
    this.refresh = refresh; 
    this.estado = true;
    getRonda(idSubasta);
    
  }

  void getRonda(int? id) async{
    print("id de la subasta");
    subasta = (await _partidaProvider.subasta(id));
    print("subasta desde el controlador");
    print(subasta);
    refresh!();
  }
}