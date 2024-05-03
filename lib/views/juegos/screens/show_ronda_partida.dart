import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pasanaku/models/partida.dart';
import '../../../models/user.dart';
import '../controllers/rondas_controller.dart';
import 'package:pasanaku/views/juegos/screens/show_apuesta_screen.dart';
import 'package:pasanaku/views/shared/widgets/custom_filled_button.dart';

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
  final RondaController _con = RondaController(); // Controlador
  bool isLoading = true; // Estado de carga

  @override
  void initState() {
    super.initState();

    int? id = widget.rondaPartida?.id;

    if (id == null) { // Verificación de nulidad
      print('Error: id es null'); // Para depuración
      return;
    }

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _con.init(context, refresh, id); // Iniciar el controlador
      setState(() {
        isLoading = false; // Estado de carga
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalle de Subasta"),
      ),
      body: Center(
        child: isLoading
          ? const CircularProgressIndicator() // Indicador de carga
          : buildRondaDetails(), // Mostrar detalles de la ronda
      ),
    );
  }

  Widget buildRondaDetails() {
    if (widget.rondaPartida == null) { // Verificar nulidad
      return const Text("Cargando datos..."); // Mensaje si no hay datos
    }

    final subasta = _con.subasta; // Asignar subasta para reutilizar

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
            subasta?.fechaInicio?.toString() ?? "Cargando...", // Manejo seguro
          ),
        ),
        ListTile(
          title: const Text("Estado"),
          subtitle: Text(
            subasta?.estado?.toString() ?? "No disponible", // Manejo seguro
          ),
        ),
        if (subasta?.ganador != null) // Verificar nulidad
          ListTile(
            title: const Text("Ganador"),
            subtitle: Text(subasta?.ganador ?? "No disponible"), // Manejo seguro
          )
        else
          const ListTile(
            title: Text("Ganador"),
            subtitle: Text("aún no hay ganador"),
          ),

        if (subasta?.estado != 'Iniciada') // Verificar estado
          SizedBox(
            width: double.infinity,
            height: 60,
            child: CustomFilledButton(
              text: 'Pujar',
              buttonColor: const Color(0xFFFDE047), // Amarillo
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShowApuestaScreen(
                      partida: widget.partida,
                      user: widget.user,
                      rondaPartida: widget.rondaPartida,
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  void refresh() {
    setState(() {}); // Actualizar la UI
  }
}
