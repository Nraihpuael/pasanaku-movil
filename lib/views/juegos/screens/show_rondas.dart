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
  static String simpleDateFormat(String iso8601Date) {
    DateTime dateTime = DateTime.parse(iso8601Date);
    const List<String> monthNames = [
      "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio",
      "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"
    ];

    int day = dateTime.day;
    int month = dateTime.month;
    int year = dateTime.year;

    return '$day de ${monthNames[month - 1]} de $year';
  }
}
//             return GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => ShowRondaPartida(
//                             partida: widget.partida,
//                             rondaPartida:
//                                 widget.partida!.rondasEnpartida![index],
//                             user: widget.user)));
//               },
//               child: ListTile(
//                 title: Text(
//                     widget.partida!.rondasEnpartida![index].nombre.toString()),
//                 subtitle: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(widget.partida!.rondasEnpartida![index].estado),
//                     Text(widget.partida!.rondasEnpartida![index].fechaInicio
//                         .toIso8601String()),
//                     //Text(_con.subasta!.ganador)
//                   ],
//                 ),
//               ),
//             );
//           }),
//     );
//   }

//   void refresh() {
//     setState(() {});
//   }
// }





















/*ListView.builder(
                  itemCount: _con.partida!.rondasEnpartida!.length,
                  itemBuilder: (contex, index){
                    
                    return ListTile(
                      title: Text(_con.partida!.rondasEnpartida![index].nombre.toString()),
                    );
                  }
                )*/