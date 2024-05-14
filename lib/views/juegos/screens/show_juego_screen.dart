import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:pasanaku/models/juego.dart';
import 'package:pasanaku/views/juegos/controllers/show_juego_controller.dart';
import 'package:pasanaku/views/juegos/screens/show_rondas.dart';
import '../../shared/widgets/custom_filled_button.dart';

class ShowJuegoScreen extends StatefulWidget {
  final Juego? juego;
  const ShowJuegoScreen({Key? key, this.juego}) : super(key: key);

  @override
  State<ShowJuegoScreen> createState() => _ShowJuegoScreenState();
}

class _ShowJuegoScreenState extends State<ShowJuegoScreen> {
  final ShowJuegoController _con = ShowJuegoController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    int? id = widget.juego?.partida?.id?.toInt();
    if (id != null) {
      SchedulerBinding.instance!.addPostFrameCallback((_) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalle del Juego"),
      ),
      body: isLoading ? const Center(child: CircularProgressIndicator()) 
      : RefreshIndicator(
        color: Colors.amber,
        onRefresh: _handleRefresh,
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : buildGameDetails(),
        ),
      ),
    );
  }

  Widget buildGameDetails() {
    return ListView(
      padding: const EdgeInsetsDirectional.only(top: 20.0),
      // physics: NeverScrollableScrollPhysics(), // Desactivar el desplazamiento
      // shrinkWrap: true, // Ajustar al tamaño del contenido
      children: [
         (_con.partida == null) ?  const Center( child: CircularProgressIndicator()) 
         :
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListTile(
                title: const Text('Nombre'),
                subtitle: Text(_con.partida!.nombre ?? "No disponible"),
              ),
              ListTile(
                title: (( _con.partida!.estado == "Espera") ? const Text('Fecha de inicio') : const Text('Fecha de finalización')),
                subtitle: Text(
                  DateFormatter.simpleDateFormat(_con.partida!.fechaInicio?.toIso8601String() ?? 'Cargando...'),
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
              // Resto de los elementos de la lista...
              // (Omitidos para simplificar)
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
          ),
      ],
    );
    
  }

  Future<void> _handleRefresh() async {
    setState(() {
      isLoading = true; // Establecer isLoading en true mientras se actualizan los datos
    });
    int? id = widget.juego?.partida?.id?.toInt();
    if (id != null) {
      await _con.init(context, refresh, id);
    }
    setState(() {
      isLoading = false; // Cambiar isLoading de nuevo a false una vez que los datos están actualizados
    });
  }

  void refresh() {
    setState(() {});
  }
}

class DateFormatter {
  static String simpleDateFormat(String dateString) {
    try {
      DateTime dateTime = DateTime.parse(dateString);
      DateTime adjustedDateTime = dateTime.subtract(const Duration(hours: 4));
      final DateFormat formatter = DateFormat("d 'de' MMMM 'de' yyyy, h:mm a");
      return formatter.format(adjustedDateTime);
    } catch (e) {
      return 'Formato de fecha inválido';
    }
  }
}


