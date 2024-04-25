import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pasanaku/models/juego.dart';
import 'package:pasanaku/views/juegos/controllers/show_juego_controller.dart';
import 'package:pasanaku/views/juegos/screens/show_rondas.dart';

import '../../shared/widgets/custom_filled_button.dart';

class ShowJuegoScreen extends StatefulWidget {
  final Juego? juego;
  const ShowJuegoScreen({super.key, this.juego});

  @override
  State<ShowJuegoScreen> createState() => _ShowJuegoScreenState();
}

class _ShowJuegoScreenState extends State<ShowJuegoScreen> {
  final ShowJuegoController _con = ShowJuegoController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    int? id = widget.juego?.partida!.id!.toInt();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh, id!);
    });
    
  }

  //vvbvb
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("detalle juego"),
        ),
        body: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListTile(
                //titleAlignment: ListTileTitleAlignment.center,
                title: Text('Nombre'),
                subtitle: Text(_con.partida!.nombre.toString()??""),
              ),
              ListTile(
                title: Text('Fecha de inicio'),
                subtitle: Text(_con.partida!.fechaInicio!.toIso8601String()??""),
              ),
              ListTile(
                title: Text('Cuota inicial'),
                subtitle: Text(_con.partida!.coutaInicial.toString()??""),
              ),
              ListTile(
                title: Text('Lapso'),
                subtitle: Text(_con.partida!.lapso.toString()??""),
              ),
              ListTile(
                title: Text('Moneda'),
                subtitle: Text(_con.partida!.moneda.toString()??""),
              ),
              ListTile(
                title: Text('Participantes'),
                subtitle: Text(_con.partida!.participantes.toString()??""),
              ),
              ListTile(
                title: Text('Pozo'),
                subtitle: Text(_con.partida!.pozo.toString()??""),
              ),
              ListTile(
                title: Text('Número de rondas'),
                subtitle:
                    Text(_con.partida!.rondasEnpartida!.length.toString()??""),
              ),
              SizedBox(
              width: double.infinity,
              height: 60,
              child: CustomFilledButton(
                text: 'Ver Rondas',
                buttonColor: Color(0xFFFDE047),
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => ShowRondaScreen(partida: _con.partida),
                ),
              );
                  //context.go('/home');
                  //Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
                },
              )),
              
            ],
          ),
        ));
  }

  void refresh() {
    setState(() {});
  }
}
