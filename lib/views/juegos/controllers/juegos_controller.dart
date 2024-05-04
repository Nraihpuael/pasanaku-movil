import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pasanaku/models/models.dart';
import 'package:pasanaku/providers/juego_provider.dart';
import 'package:pasanaku/providers/oferta_provider.dart';
import 'package:pasanaku/providers/partida_provider.dart';

import '../../../models/juego.dart';
import '../../shared/widgets/shared_pref.dart';

class JuegosController {
  BuildContext? context;
  SharedPref _sharedPref = SharedPref();
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  Function? refresh;
  User? user;
  JuegoProvider _juegoProvider = JuegoProvider();
  PartidaProvider _partidaProvider = PartidaProvider();
  OfertaProvider _ofertaProvider = OfertaProvider();
  List<Juego> juegos = [];

  Future? init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    getJuegos(user!.id);
  }

  void getJuegos(int? id) async {
    print("id de invitado: $id");
    juegos = (await _juegoProvider.juegos(id))!;
    print(juegos);
    refresh!();
  }

  void enviarPuja(
      int puja, int subastaId, int jugadorId, BuildContext contexto) async {
    print("$puja, $subastaId, $jugadorId");
    print("respesta desde el cotrolador de la puja: =========>>>>>>>>");

    ResponseApi? responseApi =
        await _ofertaProvider.enviarPuja(jugadorId, subastaId, puja);
    print(responseApi!.message);

    if (responseApi!.message!
        .startsWith("La oferta fue realiza exitosamente")) {
      showDialog(
        context: contexto,
        builder: (BuildContext contexto) {
          return const AlertDialog(
            title: Text("La oferta fue realiza exitosamente"),
            backgroundColor: Color(0xFFFDE047),
          );
        },
      );
      Future.delayed(Duration(seconds: 2), () {
        //contexto.push('/home');
        contexto.go('/home');
      });
    } else if (responseApi!.message!
        .startsWith("No se puede ingresar pujas a esta subasta")) {
      showDialog(
        context: contexto,
        builder: (BuildContext context) {
          // Crea el diálogo
          return AlertDialog(
            title: Text(responseApi.message.toString()), // Mensaje de escaneo
            backgroundColor: const Color(0xFFFDE047),
          );
        },
      );
      Future.delayed(Duration(seconds: 2), () {
        contexto.pop();
        contexto.pop();
        //contexto.go('/home');
        //contexto.push('/home');
      });
    } else if (responseApi.message!.startsWith(
        "La puja debe ser al menos el 5% del pozo. Valor minimo permitido:")) {
      showDialog(
        context: contexto,
        builder: (BuildContext context) {
          // Crea el diálogo
          return AlertDialog(
            title: Text(responseApi.message.toString()), // Mensaje de escaneo
            backgroundColor: const Color(0xFFFDE047),
          );
        },
      );
      Future.delayed(Duration(seconds: 2), () {
        //contexto.pop();
        //contexto.push('/home');
      });
    } else if (responseApi.message!.startsWith(
        "La puja no debe exceder el 50% del pozo. Valor máximo permitido:")) {
      showDialog(
        context: contexto,
        builder: (BuildContext context) {
          // Crea el diálogo
          return AlertDialog(
            title: Text(responseApi.message.toString()), // Mensaje de escaneo
            backgroundColor: const Color(0xFFFDE047),
          );
        },
      );
      Future.delayed(Duration(seconds: 2), () {
        
        //contexto.pop();
        //contexto.push('/home');
      });
    } else if (responseApi.message!.startsWith(
        "No se puede realizar pujas ya fuiste el ganador en una subasta")) {
      showDialog(
        context: contexto,
        builder: (BuildContext context) {
          // Crea el diálogo
          return AlertDialog(
            title: Text(responseApi.message.toString()), // Mensaje de escaneo
            backgroundColor: const Color(0xFFFDE047),
          );
        },
      );
      Future.delayed(Duration(seconds: 2), () {
        //contexto.pop();
        contexto.push('/home');
      });
    } else {
      showDialog(
        context: contexto,
        builder: (BuildContext context) {
          // Crea el diálogo
          return AlertDialog(
            title: Text(responseApi.message.toString()), // Mensaje de escaneo
            backgroundColor: const Color(0xFFFDE047),
          );
        },
      );
      Future.delayed(Duration(seconds: 2), () {
        contexto.pop();
        //contexto.push('/home');
      });
    }
  }
}
