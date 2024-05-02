// ignore_for_file: avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pasanaku/config/router/app_router.dart';
import 'package:pasanaku/config/theme/app_theme.dart';
import 'package:pasanaku/firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  //await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}
bool _isBackgroundHandlerConfigured = false; // Marca si ya se ha configurado

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  NotificationService() {
    _initializeLocalNotifications(); // Inicializa notificaciones locales
    _configureFirebaseMessaging(); // Configura FCM para manejar mensajes
  }

  void _initializeLocalNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("@mipmap/ic_launcher"); // Icono para Android

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) {
        print('Notification received: ${notificationResponse.payload}');
      },
    );
  }

  void _configureFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showNotification(message); // Muestra la notificación en primer plano
    });

  }

  void _showNotification(RemoteMessage message) {
    final androidDetails = AndroidNotificationDetails(
      'your_channel_id', // ID del canal
      'Your Channel Name', // Nombre del canal
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    );

    final platformDetails = NotificationDetails(
      android: androidDetails,
    );

    final title = message.notification?.title ?? 'Nueva Notificación';
    final body = message.notification?.body ?? 'Contenido de la Notificación';

    flutterLocalNotificationsPlugin.show(
      message.messageId.hashCode, // ID único para la notificación
      title,
      body,
      platformDetails,
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

   final notificationService = NotificationService(); // Instancia del servicio de notificaciones


  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  requestNotificationPermission();

  // Configurar Firebase Messaging para mensajes en segundo plano
  
  
  if (!_isBackgroundHandlerConfigured) {
    // Registra el background handler solo si no ha sido configurado
     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    _isBackgroundHandlerConfigured = true;
  }

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print("Message: ${message?.notification?.body}");
    print('Message data: ${message.data}');
    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  final fcmToken = await FirebaseMessaging.instance.getToken();
  print(fcmToken);
  runApp(MainApp(notificationService));
}

Future<void> requestNotificationPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  print('User granted permission: ${settings.authorizationStatus}');
}

class MainApp extends StatefulWidget {
  final NotificationService notificationService;

  const MainApp(this.notificationService, {super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme(selectedColor: 0).getTheme(),
    );
  }
}
