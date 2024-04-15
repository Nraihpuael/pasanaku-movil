
import 'package:flutter/material.dart';


class InvitacionesPendientesScreen extends StatelessWidget {

   static const List<String> invitaciones = [
    
    
    'Familia',
    'Amigos',
    'Tios',
    'Colegio',
    'Trabajo',
  ];

  const InvitacionesPendientesScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      
        title: Text('Invitaciones Pendientes'),
      ),
      body: ListView.builder(
        itemCount: invitaciones.length ,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(invitaciones[index]),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  iconSize: 50,
                  icon: Icon(Icons.remove_red_eye_outlined,),
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
        bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        items: const <BottomNavigationBarItem>[
          
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active),
            label: 'Invitaciones',
          ),
        ],
      ),

    );
  }

  Future<dynamic> ShowDialog(BuildContext context, int index) {
    return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Pasanaku ${invitaciones[index]}'),
                        content: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [                      
                            Text('Usted a sido invitado a participar en el juego: ${invitaciones[index]}'),
                            Text('Con un monto de: 1000 Bs.'),
                            Text('pago por ronda: 100 Bs.'),
                            Text('Numero de Rondas: 10'),
                            Text('Fecha de inicio: 10/05/2024'),
                          ],
                        ),
                        actions: [
                          FloatingActionButton(
                            child: Text('Aceptar'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          FloatingActionButton(
                            child: Text('Rechazar'),
                            onPressed: () {
                              // Aquí iría la lógica para rechazar la invitación
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
  }
}
