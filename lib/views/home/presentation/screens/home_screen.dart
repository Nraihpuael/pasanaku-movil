import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      
      appBar: AppBar(
        title: const Text('Bienvenido'),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/logo_pasanaku.png'), // Cambia por la ruta de la imagen del usuario
            ),
          ),
        ],
      ),
      body:const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              child: Column(
                children: [
                  
                  ListTile(
                    leading: Icon(Icons.play_circle_filled),
                    title: Text('Familia'),
                    subtitle: Text('En Juego'),
                    
                  ),
                  SizedBox( height: 30 ),
                  ListTile(
                    leading: Icon(Icons.stop),
                    title: Text('Trabajo'),
                    subtitle: Text('Finalizado'),
                  ),
                  SizedBox( height: 30 ),
                  ListTile(
                    leading: Icon(Icons.play_circle_filled),
                    title: Text('Amigos'),
                    subtitle: Text('En Juego'),
                  ),
                  SizedBox( height: 30 ),
                  ListTile(
                    leading: Icon(Icons.play_circle_filled),
                    title: Text('Familia Arauz'),
                    subtitle: Text('En Juego'),
                  ),
                ],
              ),
              
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        
        onTap: (value) {
          switch (value) {
            case 0:
              context.push('/invitaciones-pendientes');
              break;
            case 1:
              context.push('/home');
              break;
            case 2:
              context.push('/invitaciones-pendientes');
              break;
            default:
          }
        },
        items: const <BottomNavigationBarItem>[
          
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Notificaciones',
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
}

