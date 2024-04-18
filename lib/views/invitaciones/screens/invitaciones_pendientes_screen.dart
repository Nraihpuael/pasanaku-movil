
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pasanaku/providers/invitacion_provider.dart';
import 'package:pasanaku/views/invitaciones/controllers/invitaciones_pendientes_controller.dart';


class InvitacionesPendientesScreen extends StatefulWidget {
  
  const InvitacionesPendientesScreen({super.key});

  @override
  State<InvitacionesPendientesScreen> createState() => _InvitacionesPendientesScreenState();
}

class _InvitacionesPendientesScreenState extends State<InvitacionesPendientesScreen> {
  
  InvitacionesPendientesController _con = InvitacionesPendientesController();
  
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
    print('invitaciones dentro de invtaciones pend ${_con.invitaciones.length}');
    final textStyles = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
      
        title: Text('Invitaciones Pendientes'),
      ),
      body: ListView.builder(
        itemCount: _con.invitaciones.length ,
        itemBuilder: (context, index) {
          return ListTile(            
            title: Text(_con.invitaciones[index].partidaNombre.toString().toUpperCase()),
            subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Monto: ${_con.invitaciones[index].partidaPozo.toString()}"),
                Text("Fecha Incio: ${_con.invitaciones[index].partidaFecha.toString()}")
              ],
            ),
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
                        title: Text('Pasanaku ${_con.invitaciones[index].partidaNombre.toString().toUpperCase()}'),
                        content: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [                      
                            Text('Usted a sido invitado a participar en el juego: ${_con.invitaciones[index].partidaNombre.toString().toUpperCase()}'),
                            Text('Con un monto de: ${_con.invitaciones[index].partidaPozo}'),
                            Text('pago por ronda: 100 Bs.'),
                            Text('Numero de Rondas: 10'),
                            Text('Fecha de inicio: ${DateTime.parse(_con.invitaciones[index].partidaFecha.toString())}'),
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
  void refresh(){
  setState(() {
    
  });
}

}
