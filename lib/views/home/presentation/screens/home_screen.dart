import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:pasanaku/config/config.dart';
import 'package:pasanaku/models/invitacion.dart';
import 'package:pasanaku/providers/invitacion_provider.dart';
import 'package:pasanaku/views/home/presentation/controllers/home_controller.dart';
import 'package:pasanaku/views/shared/widgets/custom_filled_button.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  HomeController _con = HomeController();  
  


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
    
    final textStyles = Theme.of(context).textTheme;
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: SizedBox(
                height: 200,
                child: 
                 
              
                ListView.builder(
                        //itemCount: _con.invitaciones.length,
                        itemBuilder: (BuildContext context, index){
                          Invitacion invitacion = _con.invitaciones[index];
                          return Text(          
                            invitacion.nombre.toString()                        
                          );
                        },
                ),
              ),
            ),
            
            /*Card(
              child: Column(
                children: [
                  
                  /*ListTile(
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
                  ),*/
                ],

              ),
              
            ),*/
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


Widget _drawer(TextTheme styles, HomeController con){

  return Drawer(

    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Color(0xFFFDE047),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                con.user?.email??'',
                style: styles.titleMedium,
                maxLines: 1,
              ),
              SizedBox(height: 10,),
              Text(
                'Correo',
                style: styles.titleSmall,
                maxLines: 1,
              ),
              
              
            ],
          )
        ),
        SizedBox(
            width: double.infinity,
            height: 50,
            child: CustomFilledButton(
              text: 'Cerrar sesion',
              buttonColor: Color(0xff4339B0),
              onPressed: (){
                con.logout();
              },
            )
          )
        
        
        
      ],
    ),
  );

  
}

void refresh(){
  setState(() {
    
  });
}

}
