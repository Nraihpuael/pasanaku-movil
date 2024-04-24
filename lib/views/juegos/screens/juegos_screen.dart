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
            child: ListTile(
              title: Text(_con.juegos[index].partida!.nombre!.toUpperCase()
                  .toString()
                  .toUpperCase()),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "Estado: ${_con.juegos[index].partida!.estado.toString()}"),
                  Text(
                      "Cuota: ${_con.juegos[index].partida!.fechaInicio.toString()}")
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