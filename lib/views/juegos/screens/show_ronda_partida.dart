// ignore_for_file: avoid_print

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

  const ShowRondaPartida({
    Key? key,
    this.partida,
    this.rondaPartida,
    this.user,
  }) : super(key: key);

  @override
  State<ShowRondaPartida> createState() => _ShowRondaPartidaState();
}

class _ShowRondaPartidaState extends State<ShowRondaPartida> {
  final RondaController _con = RondaController(); // Final para mayor seguridad
  bool isLoading = true; // Controlar el estado de carga

  @override
  void initState() {
    super.initState();

    int? id = widget.rondaPartida?.id;

    if (id == null) { // Verificar id antes de usar
      print('Error: id es null'); // Para depuración
      return;
    }

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _con.init(context, refresh, id); // Iniciar controlador si id no es nulo
      setState(() {
        isLoading = false; // Cambiar estado de carga
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalle del Juego"),
      ),
      body: Center(
        child: isLoading
          ? const CircularProgressIndicator() // Indicador de carga
          : buildRondaDetails(), // Mostrar detalles de la ronda
      ),
    );
  }

  Widget buildRondaDetails() {
    if (widget.rondaPartida == null) { // Si rondaPartida es nulo
      return const Text("Cargando datos..."); // Mensaje de carga
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: const Text("Nombre"),
          subtitle: Text(widget.rondaPartida?.nombre ?? "No disponible"), // Manejo seguro
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



              /*
              ListTile(
                title: Text('Cuota inicial'),
                subtitle: Text(_con.partida!.coutaInicial.toString()??""),
              ),
              ListTile(
                title: Text('Lapso'),
                subtitle: Text(_con.partida!.lapso.toString()??""),

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
                subtitle: Text(_con.subasta!.ganador.toStri_con.subasta!.estado.toString() != 'Iniciada'ng()),
              ): Text("Aun no se encuentra ganador"),*/
              
              //print(_con.subasta!.estado.toString() != 'Iniciada'),
              if (_con.subasta!.estado.toString() != 'Iniciada' )
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: CustomFilledButton(
                  text: 'Pujarr',
                  buttonColor: Color(0xFFFDE047),
                  onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => ShowApuestaScreen(partida: widget.partida, user: widget.user, rondaPartida: widget.rondaPartida,),
                  ),
                  );
                  },
                )
              
              ) 
              
            ],
          ),
        ));
  }

  void refresh() {
    setState(() {});
  }
}
