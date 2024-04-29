import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pasanaku/models/partida.dart';
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
        ListTile(
          title: const Text("Fecha de inicio"),
          subtitle: Text(
            _con.subasta?.fechaInicio?.hour?.toString() ?? "Cargando..", // Manejo seguro
          ),
        ),
      ],
    );
  }

  void refresh() {
    setState(() {});
  }
}

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