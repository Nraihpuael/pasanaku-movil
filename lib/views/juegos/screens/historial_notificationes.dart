import 'package:flutter/material.dart';

class HistorialNotificacionesScreen extends StatefulWidget {
  const HistorialNotificacionesScreen({super.key});

  @override
  _HistorialNotificacionesScreenState createState() =>
      _HistorialNotificacionesScreenState();
}

class _HistorialNotificacionesScreenState extends State<HistorialNotificacionesScreen> {
  // Datos simulados de notificaciones
  final List<Map<String, dynamic>> notificaciones = [
    {
      'title': 'Invitación a juego',
      'body': 'Fuiste invitado a un nuevo juego de pasanaku.',
      'fecha': DateTime(2024, 5, 15, 14, 30), // Fecha y hora
    },
    {
      'title': 'Recordatorio de pago',
      'body': 'No olvides pagar tu cuota mensual para el pasanaku.',
      'fecha': DateTime(2024, 5, 20, 10, 0),
    },
    {
      'title': 'Nueva actualización disponible',
      'body': 'Una nueva versión de la aplicación está disponible para descargar.',
      'fecha': DateTime(2024, 6, 1, 9, 45),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Historial de Notificaciones"),
      ),
      body: ListView.builder(
        itemCount: notificaciones.length,
        itemBuilder: (context, index) {
          final notificacion = notificaciones[index];
          final formattedDate = DateFormatter.simpleDateFormat(notificacion['fecha'].toIso8601String() ?? "");

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
                notificacion['title'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(notificacion['body']), // Muestra el cuerpo
              trailing: Text(formattedDate), // Muestra la fecha
            ),
          );
        },
      ),
    );
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


/////////////////////////////// CON EL CONTROLADOR ////////////////////////////////////////// 


// import 'package:flutter/material.dart';
// import 'package:your_app/controllers/historial_notificaciones_controller.dart'; // Ajusta el nombre del paquete según tu estructura de proyecto

// class HistorialNotificacionesScreen extends StatefulWidget {
//   const HistorialNotificacionesScreen({super.key});

//   @override
//   _HistorialNotificacionesScreenState createState() =>
//       _HistorialNotificacionesScreenState();
// }

// class _HistorialNotificacionesScreenState extends State<HistorialNotificacionesScreen> {
//   final HistorialNotificacionesController _controller = HistorialNotificacionesController();
//   bool _isLoading = true; // Para controlar el estado de carga

//   @override
//   void initState() {
//     super.initState();
//     _controller.init(context, refresh); // Inicia el controlador
//     _controller.loadNotificaciones().then((_) {
//       setState(() {
//         _isLoading = false; // Cambia el estado de carga
//       });
//     });
//   }

//   void refresh() {
//     setState(() {}); // Método para refrescar la pantalla
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Historial de Notificaciones"),
//       ),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator()) // Indicador de carga
//           : (_controller.notificaciones.isEmpty)
//               ? const Center(
//                   child: Text('No hay notificaciones'), // Sin notificaciones
//                 )
//               : ListView.builder(
//                   itemCount: _controller.notificaciones.length,
//                   itemBuilder: (context, index) {
//                     final notificacion = _controller.notificaciones[index];
//                     final formattedDate = DateFormatter.simpleDateFormat(
//                         notificacion.fecha.toIso8601String());

//                     return Container(
//                       margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Margen
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(12),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.3),
//                             spreadRadius: 1,
//                             blurRadius: 4,
//                             offset: const Offset(1, 2), // Sombra suave
//                           ),
//                         ],
//                         border: Border.all(color: Colors.grey.shade300),
//                       ),
//                       child: ListTile(
//                         title: Text(
//                           notificacion.title,
//                           style: const TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         subtitle: Text(notificacion.body),
//                         trailing: Text(formattedDate), // Muestra la fecha
//                       ),
//                     );
//                   },
//                 ),
//     );
//   }
// }

// class DateFormatter {
//   static String simpleDateFormat(String iso8601Date) {
//     DateTime dateTime = DateTime.parse(iso8601Date);
//     const List<String> monthNames = [
//       "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio",
//       "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"
//     ];

//     int day = dateTime.day;
//     int month = dateTime.month;
//     int year = dateTime.year;

//     return '$day de ${monthNames[month - 1]} de $year';
//   }
// }




