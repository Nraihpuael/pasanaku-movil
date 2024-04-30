import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:pasanaku/views/juegos/controllers/juegos_controller.dart';
import 'package:pasanaku/views/juegos/screens/show_juego_screen.dart';



class JuegosScreen extends StatefulWidget {
  const JuegosScreen({super.key});

  @override
  State<JuegosScreen> createState() => _JuegosScreenState();
}

class _JuegosScreenState extends State<JuegosScreen> {

  JuegosController _con = JuegosController();

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
        title: Text('Juegos'),
      ),
      body: ListView.builder(
        itemCount: _con.juegos.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShowJuegoScreen(juego: _con.juegos[index]),
                ),
              );
              //Navigator.push(context, context.push('/show-juego') as Route<Object?>);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12), // Margen alrededor del contenedor
              padding: const EdgeInsets.all(16), // Espacio interno
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12), // Bordes redondeados
                border: Border.all(color: Colors.grey.shade300), // Borde gris claro
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(1, 3), // Sombra desplazada
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded( // Permite expansión horizontal
                    child: Column( 
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_con.juegos[index].partida!.nombre!.toUpperCase() ?? 'Sin nombre',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "Estado: ${_con.juegos[index].partida!.estado.toString()}",
                          style: const TextStyle(color: Colors.grey),
                        ),
                        Text(
                          "Cuota inicial: ${_con.juegos[index].partida!.coutaInicial.toString()}",
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward, color: Colors.grey), // Icono al final
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