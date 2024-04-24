import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pasanaku/models/juego.dart';
import 'package:pasanaku/models/partida.dart';
import 'package:pasanaku/views/juegos/controllers/show_juego_controller.dart';


class ShowJuegoScreen extends StatefulWidget {
  final Juego? juego;
  const ShowJuegoScreen({super.key, this.juego});
  
  @override
  State<ShowJuegoScreen> createState() => _ShowJuegoScreenState();
}

class _ShowJuegoScreenState extends State<ShowJuegoScreen> {

  ShowJuegoController _con = ShowJuegoController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) { 
      _con.init(context, refresh);
    });
  }

  //vvbvb
  @override
  Widget build(BuildContext context) {
    Partida partida = _con.getJueg(2) as Partida;
    print("error dectecrtado");
    print(partida);
    return Scaffold(

      appBar: AppBar(
        title: Text("detalle juego"),
      ),
      body: SizedBox(

        child: Column(
          children: [
              Text(partida.fechaInicio.toString()),
              Text(partida.coutaInicial.toString())
          ],
        ),
      ),
    
    );
  }

  refresh() {
    setState(() {
    
    });
  }
}