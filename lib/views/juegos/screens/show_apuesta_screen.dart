import 'package:flutter/material.dart';
import 'package:pasanaku/models/models.dart';
import 'package:pasanaku/views/shared/shared.dart';

import '../../../models/partida.dart';
import '../controllers/juegos_controller.dart';

class ShowApuestaScreen extends StatefulWidget {
  final Partida? partida;
  final User? user;
  final RondasEnpartida? rondaPartida;
  const ShowApuestaScreen(
      {super.key, this.partida, this.user, this.rondaPartida});

  @override
  State<ShowApuestaScreen> createState() => _ShowApuestaScreenState();
}

class _ShowApuestaScreenState extends State<ShowApuestaScreen> {
  JuegosController _con = JuegosController();
  TextEditingController pujaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Puja'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: pujaController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'puja'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "por favor ingresar una puja";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  CustomFilledButton(
                    text: 'Enviar Puja',
                    buttonColor: Color(0xFFFDE047),
                    onPressed: () {
                      int puja = int.parse(pujaController.text);
                      int subastaId = widget.rondaPartida!.id;
                      int? jugadorId = widget.user!.id;
                      _con.enviarPuja(puja, subastaId, jugadorId!);

                      
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Mensaje mostrado después de presionar el botón'),
                          duration:
                              Duration(seconds: 2), // Duración del SnackBar
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
