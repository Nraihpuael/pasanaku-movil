import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:pasanaku/models/transaccion.dart';
import 'package:pasanaku/views/juegos/controllers/transaccion_controller.dart';
import 'package:pasanaku/views/juegos/screens/image_scanner_screen.dart';
import 'package:pasanaku/views/shared/shared.dart';

class TransaccionesScreen extends StatefulWidget {
  const TransaccionesScreen({Key? key}) : super(key: key);

  @override
  _TransaccionesScreenState createState() => _TransaccionesScreenState();
}

class _TransaccionesScreenState extends State<TransaccionesScreen> {
  final TransaccionController _con = TransaccionController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transacciones"),
      ),
      body: ListView.builder(
        itemCount: _con.transaccion.length,
        itemBuilder: (context, index) {
          final transaccion =
              _con.transaccion[index]; // Obtener el elemento actual
          return GestureDetector(
            onTap: () {
              // Navegar a la pantalla de detalles usando idGanador
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetallesTransaccionScreen(
                    transaccion: transaccion,
                    idTransaccion: transaccion.id.toString(), // Pasar el ID
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(
                  vertical: 8, horizontal: 12), // Margen
              padding: const EdgeInsets.all(16), // Espacio interno
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12), // Bordes redondeados
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(1, 3), // Sombra suave
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween, // Elementos separados
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // Alineación izquierda
                      children: [
                        Text(
                          transaccion.receptor!.nombre.toString(), // Ganador
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(transaccion.estado
                            .toString()), // Estado de la transacción
                        Text("Monto: ${transaccion.monto} Bs."), // Monto
                      ],
                    ),
                  ),
                  Text(
                    "Fecha límite: ${DateFormatter.simpleDateFormat(transaccion.fecha.toString() ?? "")}", // Fecha límite
                    
                    style: const TextStyle(color: Colors.grey), // Texto en gris
                  ),
                  const Icon(Icons.arrow_forward,
                      color: Colors.grey), // Icono para interacción
                ],
              ),
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

class DetallesTransaccionScreen extends StatefulWidget {
  final String? idTransaccion;
  final Transaccion? transaccion;

  const DetallesTransaccionScreen(
      {this.idTransaccion, this.transaccion, Key? key})
      : super(key: key);

  @override
  State<DetallesTransaccionScreen> createState() =>
      _DetallesTransaccionScreenState();
}

class _DetallesTransaccionScreenState extends State<DetallesTransaccionScreen> {
  GlobalKey? _globalKey;

  @override
  void initState() {
    super.initState();
    _globalKey = GlobalKey();
  }

  Future<void> _saveImage() async {
    try {
      print(widget.idTransaccion);
      RenderRepaintBoundary boundary = _globalKey!.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      final result = await ImageGallerySaver.saveImage(pngBytes);
      print('Image saved to gallery: $result');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Imagen guardada en galeria'),
        ),
      );
    } catch (e) {
      print('Error saving image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al guardar imagen'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalles de la Transacción"),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: [
            ListTile(
              title: Text(widget.transaccion!.ronda.toString()),
            ),
            ListTile(
              title: const Text("Estado de la transaccion"),
              subtitle: Text(widget.transaccion!.estado.toString()),
            ),
            ListTile(
              title: const Text("Fecha limite a cancelar"),
              subtitle: Text(DateFormatter.simpleDateFormat(widget.transaccion!.fecha.toString() ?? "")),
                            // trailing: Text(DateFormatter.simpleDateFormat(widget.transaccion!.fecha.toString() ?? "")),
            ),
            ListTile(
              title: const Text("Monto a Pagar"),
              subtitle: Text(widget.transaccion!.monto.toString()),
            ),
            ListTile(
              title: const Text("Ganador: "),
              subtitle: Text(widget.transaccion!.receptor!.nombre.toString()),
            ),
            if (widget.transaccion!.receptor!.imagen != null)
              Column(
                children: [
                  RepaintBoundary(
                    key: _globalKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          widget.transaccion!.receptor!.imagen.toString(),
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              );
                            }
                          },
                          errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) {
                            return const Text('Error loading image');
                          },
                        ),
                      ],
                    ),
                  ),
                   const SizedBox(height: 20),
                  ElevatedButton(
                  onPressed: _saveImage,
                  child: const Text('Guardar Imagen'),
            ),
                ],
                
              ),
           
            CustomFilledButton(
              text: "Pagar Transaccion",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImageScannerScreen(
                        idRonda: widget.idTransaccion
                        // Pasar el ID
                        ),
                  ),
                );
              },
            )
          ],
        )),
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