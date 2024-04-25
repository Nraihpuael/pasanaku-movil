
import 'package:flutter/material.dart';
import 'package:pasanaku/models/models.dart';
import 'package:pasanaku/models/partida.dart';
import 'package:pasanaku/views/juegos/screens/show_apuesta_screen.dart';


class ShowRondaScreen extends StatefulWidget {
  final Partida? partida;
  final RondasEnpartida? rondaPartida;
  final User? user;
  const ShowRondaScreen({super.key, this.partida, this.user, this.rondaPartida});

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
      body: ListView.builder(
                  itemCount: widget.partida!.rondasEnpartida!.length,
                  itemBuilder: (contex, index){
                    
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context, MaterialPageRoute(builder: (context) => ShowApuestaScreen( partida: widget.partida ,rondaPartida: widget.partida!.rondasEnpartida![index], user: widget.user) )
                          
                        );
                      },
                      child: ListTile(
                        title: Text(widget.partida!.rondasEnpartida![index].nombre.toString()),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.partida!.rondasEnpartida![index].estado),
                            Text(widget.partida!.rondasEnpartida![index].fechaInicio.toIso8601String())
                          ],
                        ),
                      ),
                    );
                  }
                ),
    );
  }
}





















/*ListView.builder(
                  itemCount: _con.partida!.rondasEnpartida!.length,
                  itemBuilder: (contex, index){
                    
                    return ListTile(
                      title: Text(_con.partida!.rondasEnpartida![index].nombre.toString()),
                    );
                  }
                )*/