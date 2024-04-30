import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pasanaku/views/juegos/controllers/transaccion_controller.dart';

class TransaccionesScreen extends StatefulWidget {
  const TransaccionesScreen({Key? key}) : super(key: key);

  @override
  _TransaccionesScreenState createState() => _TransaccionesScreenState();

}

class _TransaccionesScreenState extends State<TransaccionesScreen> {
  
  TransaccionController _con = TransaccionController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }
  
  final List<Map<String, dynamic>> transacciones = [
    {
      'ganador': 'Juan Pérez',
      'idGanador': '12345',
      'fechaLimite': '2024-05-30',
      'monto': 100,
      'estado': 'Pendiente',
    },
    {
      'ganador': 'Ana López',
      'idGanador': '12346',
      'fechaLimite': '2024-06-15',
      'monto': 150,
      'estado': 'Pagado',
    },
    {
      'ganador': 'Carlos Martínez',
      'idGanador': '12347',
      'fechaLimite': '2024-07-01',
      'monto': 200,
      'estado': 'Pendiente',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transacciones"),
      ),
      body: ListView.builder(
        itemCount: _con.transaccion.length,
        itemBuilder: (context, index) {
          final transaccion = _con.transaccion[index]; // Obtener el elemento actual
          return GestureDetector(
            onTap: () {
              // Navegar a la pantalla de detalles usando idGanador
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetallesTransaccionScreen(
                    idTransaccion: transaccion.id.toString(), // Pasar el ID
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12), // Margen
              padding: const EdgeInsets.all(16), // Espacio interno
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12), // Bordes redondeados
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(1, 3), // Sombra suave
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Elementos separados
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Alineación izquierda
                      children: [
                        Text(
                          transaccion.receptor!.nombre, // Ganador
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(transaccion.estado.toString()), // Estado de la transacción
                        Text("Monto: ${transaccion.monto} Bs."), // Monto
                      ],
                    ),
                  ),
                  Text(
                    "Fecha límite: ${transaccion.fecha}", // Fecha límite
                    style: const TextStyle(color: Colors.grey), // Texto en gris
                  ),
                  const Icon(Icons.arrow_forward, color: Colors.grey), // Icono para interacción
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

class DetallesTransaccionScreen extends StatelessWidget {
  final String idTransaccion;

  const DetallesTransaccionScreen({required this.idTransaccion, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalles de la Transacción"),
      ),
      body: Center(
        child: Text("Detalles de la transacción con ID: $idTransaccion"), // Mostrar detalles usando el ID
      ),
    );
  }
}