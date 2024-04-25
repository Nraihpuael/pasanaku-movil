import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pasanaku/models/models.dart';
import 'package:pasanaku/models/partida.dart';
import 'package:pasanaku/views/juegos/controllers/rondas_controller.dart';
import 'package:pasanaku/views/juegos/screens/show_apuesta_screen.dart';
import 'package:pasanaku/views/juegos/screens/show_ronda_partida.dart';

class ShowRondaScreen extends StatefulWidget {
  final Partida? partida;
  final List<RondasEnpartida?>? rondaPartida;
  final User? user;
  const ShowRondaScreen(
      {super.key, this.partida, this.user, this.rondaPartida});

  @override
  State<ShowRondaScreen> createState() => _ShowRondaScreenState();
}

class _ShowRondaScreenState extends State<ShowRondaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rondas de la partida'),
      ),
      body: ListView.builder(
          itemCount: widget.partida!.rondasEnpartida!.length,
          itemBuilder: (contex, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ShowRondaPartida(
                            partida: widget.partida,
                            rondaPartida:
                                widget.partida!.rondasEnpartida![index],
                            user: widget.user)));
              },
              child: ListTile(
                title: Text(
                    widget.partida!.rondasEnpartida![index].nombre.toString()),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.partida!.rondasEnpartida![index].estado),
                    Text(widget.partida!.rondasEnpartida![index].fechaInicio
                        .toIso8601String()),
                    //Text(_con.subasta!.ganador)
                  ],
                ),
              ),
            );
          }),
    );
  }

  void refresh() {
    setState(() {});
  }
}





















/*ListView.builder(
                  itemCount: _con.partida!.rondasEnpartida!.length,
                  itemBuilder: (contex, index){
                    
                    return ListTile(
                      title: Text(_con.partida!.rondasEnpartida![index].nombre.toString()),
                    );
                  }
                )*/