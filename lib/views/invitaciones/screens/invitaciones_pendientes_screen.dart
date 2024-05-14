import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pasanaku/providers/invitacion_provider.dart';
import 'package:pasanaku/views/invitaciones/controllers/invitaciones_pendientes_controller.dart';

class InvitacionesPendientesScreen extends StatefulWidget {
  const InvitacionesPendientesScreen({super.key});

  @override
  State<InvitacionesPendientesScreen> createState() =>
      _InvitacionesPendientesScreenState();
}

class _InvitacionesPendientesScreenState
    extends State<InvitacionesPendientesScreen> {
  final InvitacionesPendientesController _con = InvitacionesPendientesController();
  late bool _isLoading;
  String _errorMessage = '';


  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _errorMessage = '';
    _loadNotificaciones();
  }

  void _loadNotificaciones() async {
    try {
      await _con.init(context, _refresh);
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error al cargar las notificaciones';
      });
    }
  }

  void _refresh() {
    setState(() {
      _isLoading = false;
      _errorMessage = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Invitaciones Pendientes'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? Center(child: Text(_errorMessage))
              : _buildInvitacionesList(),

      /*body: (_con.invitaciones ?? []).isEmpty
          ? const Center(
              child: Text(
                'No tiene invitaciones',
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
              ),
            )
          : _buildInvitacionesList(),*/
    );
  }

  Widget _buildInvitacionesList() {
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: (_con.invitaciones ?? []).isEmpty
          ? const Center(
              child: Text(
                'No tiene invitaciones',
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
              ),
            )
          :ListView.builder(
              itemCount: _con.invitaciones!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_con.invitaciones![index].partidaNombre
                      .toString()
                      .toUpperCase()),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "Monto: ${_con.invitaciones![index].partidaPozo.toString()}"),
                      Text(
                          "Fecha Incio: ${DateFormatter.simpleDateFormat(_con.invitaciones![index].partidaFecha.toString() ?? "")}")
                          
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        iconSize: 50,
                        icon: Icon(
                          Icons.remove_red_eye_outlined,
                        ),
                        onPressed: () {
                          // Lógica para aceptar la invitación
                          ShowDialog(context, index);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          // Lógica para rechazar la invitación
                          //ShowDialog(context, index);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
  
  Future<void> _handleRefresh() async {
    // Realiza la lógica de actualización de los datos aquí
    _loadNotificaciones();
  }
  Future<dynamic> ShowDialog(BuildContext context, int index) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
              'Invitacion a: ${_con.invitaciones![index].partidaNombre.toString().toUpperCase()}'),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  'Usted a sido invitado a participar en el juego: ${_con.invitaciones![index].partidaNombre.toString().toUpperCase()}'),
              Text('Con un monto de: ${_con.invitaciones![index].partidaPozo}'),
              Text('pago por ronda: 100 Bs.'),
              Text('Numero de Rondas: 10'),
              Text(
                  'Fecha de inicio: ${DateFormatter.simpleDateFormat(_con.invitaciones![index].partidaFecha.toString() ?? "")}'),
                  
            ],
          ),
           actions: [
          // Botón pequeño para "Aceptar"
          SizedBox(
            width: 70, // Ancho más pequeño
            height: 40, // Altura más pequeña
            child: FloatingActionButton(
              mini: true, // Hace que el botón sea más pequeño
              child: Text(
                'Aceptar',
                style: TextStyle(fontSize: 14, color: Color(0xff4339B0)), // Tamaño del texto
              ),
              onPressed: () {
                _con.aceptarInvitacion(_con.invitaciones![index].id);
                Navigator.of(context).pop();
                context.go('/home');
              },
            ),
          ),
          SizedBox(width: 10), // Espacio entre botones

          // Botón pequeño para "Rechazar"
          SizedBox(
            width: 70, // Ancho más pequeño
            height: 40, // Altura más pequeña
            child: FloatingActionButton(
              mini: true, // Hace que el botón sea más pequeño
              child: Text(
                'Rechazar',
                style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 163, 9, 0)), // Tamaño del texto
              ),
              onPressed: () {
                _con.rechazarInvitacion(_con.invitaciones![index].id);
                Navigator.of(context).pop();
                context.go('/home');
              },
            ),
          ),
        ],
        );
      },
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
      // DateTime adjustedDateTime = dateTime.subtract(const Duration(hours: 4));

      // Crea el formateador asegurándote de usar comillas para "de"
      final DateFormat formatter = DateFormat("d 'de' MMMM 'de' yyyy, h:mm a");

      // Devuelve la fecha formateada con la corrección de 4 horas
      return formatter.format(dateTime);
    } catch (e) {
      // Devuelve un mensaje de error si algo sale mal
      return 'Formato de fecha inválido';
    }
  }
}