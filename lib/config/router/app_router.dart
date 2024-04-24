import 'package:go_router/go_router.dart';
import 'package:pasanaku/views/auth/auth.dart';
import 'package:pasanaku/views/home/presentation/screens/home_screen.dart';
import 'package:pasanaku/views/invitaciones/invitaciones.dart';
import 'package:pasanaku/views/juegos/screens/show_juego_screen.dart';

import '../../views/juegos/screens/juegos_screen.dart';


final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    ///* Auth Routes
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/invitaciones-pendientes',
      builder: (context, state) => const InvitacionesPendientesScreen(),
    ),
    GoRoute(
      path: '/show-juego',
      builder: (context, state) => const ShowJuegoScreen(),
    ),
    GoRoute(
      path: '/juegos',
      builder: (context, state) => const JuegosScreen(),
    )

 ],
  
);