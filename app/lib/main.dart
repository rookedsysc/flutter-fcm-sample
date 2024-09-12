import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fcm_sample/fcm_register_service.dart';
import 'package:flutter_fcm_sample/fcm_request_service.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  PermissionStatus status = await Permission.notification.request();
  if (status.isGranted) {
    FCMRegisterService fcmRegisterService = FCMRegisterService();
    fcmRegisterService.registerFCMToken();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FCM SAMPLE APP',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'FCM SAMPLE APP'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OutlinedButton(
              child: Text("Send FCM Message"),
              onPressed: () async {
                FCMReqeustService fcmReqeustService = FCMReqeustService();
                String message = await fcmReqeustService.sendFCMTokenToServer();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(message),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
