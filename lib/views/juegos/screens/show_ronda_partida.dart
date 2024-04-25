import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pasanaku/models/partida.dart';

import '../../../models/user.dart';
import '../controllers/rondas_controller.dart';

class ShowRondaPartida extends StatefulWidget {
  final Partida? partida;
  final RondasEnpartida? rondaPartida;
  final User? user;

  const ShowRondaPartida(
      {super.key, this.partida, this.rondaPartida, this.user});

  @override
  State<ShowRondaPartida> createState() => _ShowRondaPartidaState();
}

class _ShowRondaPartidaState extends State<ShowRondaPartida> {
  RondaController _con = RondaController();
  void mostrarMensaje(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('¡Mensaje emergente mostrado!'),
        duration: Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Cerrar',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.rondaPartida);
    int? id = widget.rondaPartida?.id;
    print('id:  =>>>>>   $id');
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh, id!);
    });
  }

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
                subtitle: Text(widget.rondaPartida!.nombre),
              ),
              ListTile(
                title: Text('Fecha de inicio'),
                subtitle: Text(_con.subasta!.fechaInicio.hour.toString()??""),
              ),/*
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
                  builder: (context) => ShowRondaScreen(partida: _con.partida, user: _con.user, rondaPartida: _con.partida!.rondasEnpartida,),
                ),
              );
                  //context.go('/home');
                  //Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
                },
              )),*/
              
            ],
          ),
        ));
  }

  void refresh() {
    setState(() {});
  }
}
