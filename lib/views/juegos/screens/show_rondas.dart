
import 'package:flutter/material.dart';
import 'package:pasanaku/models/partida.dart';


class ShowRondaScreen extends StatefulWidget {
  const ShowRondaScreen({super.key, List<RondasEnpartida>? partida});

  @override
  State<ShowRondaScreen> createState() => _ShowRondaScreenState();
}

class _ShowRondaScreenState extends State<ShowRondaScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
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