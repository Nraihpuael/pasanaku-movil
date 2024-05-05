import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:pasanaku/models/notificacion.dart';
import 'package:pasanaku/views/juegos/controllers/notificacion_controller.dart';




class HistorialNotificacionesScreen extends StatefulWidget {
  const HistorialNotificacionesScreen({super.key});

  @override
  _HistorialNotificacionesScreenState createState() =>
      _HistorialNotificacionesScreenState();
}


class _HistorialNotificacionesScreenState extends State<HistorialNotificacionesScreen> {
  final NotificacionController _con = NotificacionController();
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Historial de Notificaciones"),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? Center(child: Text(_errorMessage))
              : _buildNotificacionesList(),
    );
  }

  Widget _buildNotificacionesList() {
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: ListView.builder(
        itemCount: _con.notificacion.length,
        itemBuilder: (context, index) {
          final notificacion = _con.notificacion[index];
          return _buildNotificacionItem(notificacion);
        },
      ),
    );
  }

  Future<void> _handleRefresh() async {
    // Realiza la lógica de actualización de los datos aquí
    _loadNotificaciones();
  }

  Widget _buildNotificacionItem(Notificacion notificacion) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(1, 2),
          ),
        ],
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ListTile(
        title: Text(
          notificacion.title!.toUpperCase(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(notificacion.body!),
        trailing: Text(DateFormatter.simpleDateFormat(notificacion.fecha!)),
      ),
    );
  }
}


class DateFormatter {
  static String simpleDateFormat(String customDateString) {
    try {
      // Define el formato según tu entrada (puedes ajustarlo según sea necesario)
      var formatter = DateFormat('M/d/yyyy, h:mm:ss a'); // Formato de entrada
      var dateTime = formatter.parse(customDateString); // Analiza la fecha

      // Ajuste de 4 horas (si es necesario para la zona horaria deseada)
      var adjustedDateTime = dateTime.subtract(const Duration(hours: 4));

      // Formatear para mostrar fecha y hora en un formato amigable
      var displayFormat = DateFormat('d MMMM yyyy, hh:mm a'); // Formato de salida

      return displayFormat.format(adjustedDateTime); // Devuelve la fecha formateada
    } catch (e) {
      return 'Formato de fecha inválido'; // Manejo de errores
    }
  }
}











/*import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:pasanaku/views/juegos/controllers/notificacion_controller.dart';

class HistorialNotificacionesScreen extends StatefulWidget {
  const HistorialNotificacionesScreen({super.key});

  @override
  _HistorialNotificacionesScreenState createState() =>
      _HistorialNotificacionesScreenState();
}

class _HistorialNotificacionesScreenState extends State<HistorialNotificacionesScreen> {

  final NotificacionController _con = NotificacionController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }
  // Datos simulados de notificaciones
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Historial de Notificaciones"),
      ),
      body: ListView.builder(
        itemCount: _con.notificacion.length,
        itemBuilder: (context, index) {
          final notificacion = _con.notificacion[index];

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Margen para espacio entre elementos
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12), // Bordes redondeados
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: Offset(1, 2), // Sombra con desplazamiento
                ),
              ],
              border: Border.all(color: Colors.grey.shade300), // Borde gris claro
            ),
            child: ListTile(
              title: Text(
                notificacion.title.toString().toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(notificacion.body.toString()), // Muestra el cuerpo
              trailing: Text(DateFormatter.simpleDateFormat(notificacion.fecha.toString() ?? "")), // Muestra la fecha
          //final formattedDate = DateFormatter.simpleDateFormat(notificacion.fecha.toString() ?? "");
            ),
          );
        },
      ),
    );
  }

  refresh() {

    setState(() {});
  }
}

class DateFormatter {
  static String simpleDateFormat(String customDateString) {
    try {
      // Define el formato según tu entrada (puedes ajustarlo según sea necesario)
      var formatter = DateFormat('M/d/yyyy, h:mm:ss a'); // Formato de entrada
      var dateTime = formatter.parse(customDateString); // Analiza la fecha

      // Ajuste de 4 horas (si es necesario para la zona horaria deseada)
      var adjustedDateTime = dateTime.subtract(const Duration(hours: 4));

      // Formatear para mostrar fecha y hora en un formato amigable
      var displayFormat = DateFormat('d MMMM yyyy, hh:mm a'); // Formato de salida

      return displayFormat.format(adjustedDateTime); // Devuelve la fecha formateada
    } catch (e) {
      return 'Formato de fecha inválido'; // Manejo de errores
    }
  }
}



*/
