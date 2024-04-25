import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pasanaku/models/partida.dart';
import 'package:pasanaku/views/juegos/screens/show_apuesta_screen.dart';
import 'package:pasanaku/views/shared/widgets/custom_filled_button.dart';

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
                subtitle: Text(_con.subasta!.fechaInicio!.toIso8601String()),
              ),
              ListTile(
                title: Text('Fechca de incio'),
                subtitle: Text(_con.subasta!.fechaFinal!.toIso8601String()),
              ),


              ListTile(
                title: Text('Estado'),
                subtitle: Text(_con.subasta!.estado.toString()),
              ),
              if (_con.subasta?.ganador != null)
                ListTile(
                  title: Text('Ganador'),
                  subtitle: Text(_con.subasta!.ganador.toString()),
                )                        
              else
                ListTile(
                title: Text('Ganador'),
                subtitle: Text("aun no hay ganador"),
                ),  
              if (_con.subasta?.resultado != null)
                ListTile(
                  title: Text('Ganador'),
                  subtitle: Text(_con.subasta!.resultado.toString()),
                )                        
              else
                ListTile(
                title: Text('Monto'),
                subtitle: Text("No hay un monto asignado el ganador"),
                ), 
              


              /*_con.subasta!.ganador.toString() != null ?
              ListTile(
                title: Text('Ganador'),
                subtitle: Text(_con.subasta!.ganador.toString()),
              ): Text("Aun no se encuentra ganador"),*/
              SizedBox(
              width: double.infinity,
              height: 60,
              child: CustomFilledButton(
                text: 'Pujar',
                buttonColor: Color(0xFFFDE047),
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => ShowApuestaScreen(partida: widget.partida, user: widget.user, rondaPartida: widget.rondaPartida,),
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
