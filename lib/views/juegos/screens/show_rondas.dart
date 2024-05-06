import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pasanaku/models/models.dart';
import 'package:pasanaku/models/partida.dart';
import 'package:pasanaku/views/juegos/controllers/rondas_controller.dart';
import 'package:pasanaku/views/juegos/screens/show_apuesta_screen.dart';
import 'package:pasanaku/views/juegos/screens/show_ronda_partida.dart';
import 'package:intl/intl.dart';

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
      //  (_con.invitaciones ?? []).isEmpty
      //     ? const Center(
      //         child: Text(
      //           'No tiene invitaciones',
      //           style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
      //         ),
      //       )
      body:  (widget.partida!.rondasEnpartida!.length ?? 0) == 0
          ? const Center(
              child: Text(
                'No hay rondas disponibles',
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
              ),
            )
            : 
      ListView.builder(
          itemCount: widget.partida!.rondasEnpartida!.length,
          itemBuilder: (contex, index) {
            return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShowRondaPartida(
                    partida: widget.partida,
                    rondaPartida: widget.partida!.rondasEnpartida![index],
                    user: widget.user,
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12), // Espacio alrededor del contenedor
              padding: const EdgeInsets.all(16), // Espacio interno
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12), // Bordes redondeados
                border: Border.all(color: Colors.grey.shade300), // Borde gris
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(2, 3), // Sombra con desplazamiento
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.partida!.rondasEnpartida![index].nombre ?? 'Sin nombre', // Nombre de la ronda
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "Estado: ${widget.partida!.rondasEnpartida![index].estado ?? 'Desconocido'}",
                          style: const TextStyle(color: Colors.grey),
                        ),
                        Text(
                          "Fecha de inicio: ${DateFormatter.simpleDateFormat(widget.partida!.rondasEnpartida![index].fechaInicio?.toIso8601String() ?? 'Fecha no disponible')}",
                          // DateFormatter.simpleDateFormat(_con.partida?.fechaInicio?.toIso8601String() ?? "")
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward, color: Colors.grey), // Ícono para indicar interacción
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}

class DateFormatter {
  static String simpleDateFormat(String dateString) {
    try {
      // Analiza la fecha y hora a partir del formato dado
      DateTime dateTime = DateTime.parse(dateString);

      // Ajusta la diferencia horaria para Bolivia (UTC-4)
      DateTime adjustedDateTime = dateTime.subtract(const Duration(hours: 4));

      // Crea el formateador asegurándote de usar comillas para "de"
      final DateFormat formatter = DateFormat("d 'de' MMMM 'de' yyyy, h:mm a");

      // Devuelve la fecha formateada con la corrección de 4 horas
      return formatter.format(adjustedDateTime);
    } catch (e) {
      // Devuelve un mensaje de error si algo sale mal
      return 'Formato de fecha inválido';
    }
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