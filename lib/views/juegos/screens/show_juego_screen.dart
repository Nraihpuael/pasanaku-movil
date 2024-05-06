import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pasanaku/models/juego.dart';
import 'package:pasanaku/views/juegos/controllers/show_juego_controller.dart';
import 'package:pasanaku/views/juegos/screens/show_rondas.dart';
import 'package:intl/intl.dart';
import '../../shared/widgets/custom_filled_button.dart';

class ShowJuegoScreen extends StatefulWidget {
  final Juego? juego;
  const ShowJuegoScreen({super.key, this.juego});

  @override
  State<ShowJuegoScreen> createState() => _ShowJuegoScreenState();
}

class _ShowJuegoScreenState extends State<ShowJuegoScreen> {
  final ShowJuegoController _con = ShowJuegoController();
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    int? id = widget.juego?.partida?.id?.toInt();
    if (id != null) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _con.init(context, refresh, id)?.then((_) {
          setState(() {
            isLoading = false; // Cambiar el estado una vez que los datos están listos
          });
        });
      });
    } else {
      setState(() {
        isLoading = false; // Si no hay id, no hay datos por cargar
      });
    }
    // SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
    //   _con.init(context, refresh, id!);
    // });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Detalle del Juego"),
        ),
        body: Center(
        child: isLoading
          ? CircularProgressIndicator() // Mostramos un indicador de carga mientras se obtienen datos
          : buildGameDetails(), // Muestra detalles del juego si no estamos cargando
      ),
    );
  }

  // Método para construir el contenido del juego
  Widget buildGameDetails() {
    if (_con.partida == null) {
      return Text("Cargando..."); // Si partida es null, muestra un mensaje de error
    }

    // Si partida no es null, muestra los detalles
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text('Nombre'),
          subtitle: Text(_con.partida?.nombre ?? "No disponible"), // Manejo seguro
        ),
        ListTile(
          title: const Text('Fecha de inicio'),
          subtitle: Text(
            DateFormatter.simpleDateFormat(_con.partida?.fechaInicio?.toIso8601String() ?? 'Cargando...'),  // Usa el formateo simple
          ),
        ),
        ListTile(
          title: const Text('Cuota inicial'),
          subtitle: Text(_con.partida?.coutaInicial?.toString() ?? "No disponible"),
        ),
        ListTile(
          title: const Text('Lapso'),
          subtitle: Text(_con.partida?.lapso?.toString() ?? "No disponible"),
        ),
        ListTile(
          title: const Text('Moneda'),
          subtitle: Text(_con.partida?.moneda?.nombre.toString()??""),
        ),
        ListTile(
          title: const Text('Participantes'),
          subtitle: Text(_con.partida?.participantes?.toString() ?? "No disponible"),
        ),
        ListTile(
          title: const Text('Pozo'),
          subtitle: Text(_con.partida?.pozo?.toString() ?? "No disponible"),
        ),
        ListTile(
          title: const Text('Número de rondas'),
          subtitle: Text(_con.partida?.rondasEnpartida?.length?.toString() ?? "No disponible"),
        ),
        SizedBox(
  width: double.infinity,
  height: 60,
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16), // Agregar margen
    child: GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowRondaScreen(
              partida: _con.partida,
              user: _con.user,
              rondaPartida: _con.partida?.rondasEnpartida,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFDE047), // Color del botón
          borderRadius: BorderRadius.circular(12), // Bordes redondeados
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(2, 2), // Sombra con desplazamiento
            ),
          ],
        ),
        child: const Center( // Alineación del texto
          child: Text(
            'Ver Rondas',
            style: TextStyle(
              color: Colors.black, // Color del texto
              fontWeight: FontWeight.bold, // Resaltar el texto
            ),
          ),
        ),
      ),
    ),
  ),
),
      ],
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
//         body: SizedBox(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             //crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               ListTile(
//                 //titleAlignment: ListTileTitleAlignment.center,
//                 title: Text('Nombre'),
//                 subtitle: Text(_con.partida!.nombre.toString()??""),
//               ),
//               ListTile(
//                 title: Text('Fecha de inicio'),
//                 subtitle: Text(_con.partida!.fechaInicio!.toIso8601String()??""),
//               ),
//               ListTile(
//                 title: Text('Cuota inicial'),
//                 subtitle: Text(_con.partida!.coutaInicial.toString()??""),
//               ),
//               ListTile(
//                 title: Text('Lapso'),
//                 subtitle: Text(_con.partida!.lapso.toString()??""),
//               ),
//               ListTile(
//                 title: Text('Moneda'),
//                 subtitle: Text(_con.partida!.moneda.toString()??""),
//               ),
//               ListTile(
//                 title: Text('Participantes'),
//                 subtitle: Text(_con.partida!.participantes.toString()??""),
//               ),
//               ListTile(
//                 title: Text('Pozo'),
//                 subtitle: Text(_con.partida!.pozo.toString()??""),
//               ),
//               ListTile(
//                 title: Text('Número de rondas'),
//                 subtitle:
//                     Text(_con.partida!.rondasEnpartida!.length.toString()??""),
//               ),
//               SizedBox(
//               width: double.infinity,
//               height: 60,
//               child: CustomFilledButton(
//                 text: 'Ver Rondas',
//                 buttonColor: Color(0xFFFDE047),
//                 onPressed: () {
//                   Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                   builder: (context) => ShowRondaScreen(partida: _con.partida, user: _con.user, rondaPartida: _con.partida!.rondasEnpartida,),
//                 ),
//               );
//                   //context.go('/home');
//                   //Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
//                 },
//               )),
              
//             ],
//           ),
//         ));
//   }

//   void refresh() {
//     setState(() {});
//   }
// }
