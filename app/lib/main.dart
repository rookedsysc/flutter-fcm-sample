import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fcm_sample/fcm_register_service.dart';
import 'package:flutter_fcm_sample/fcm_request_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  PermissionStatus status = await Permission.notification.request();
  if (status.isGranted) {
    FCMRegisterService fcmRegisterService = FCMRegisterService();
    fcmRegisterService.registerFCMToken();
  }

  initializeNotifications(); // flutter_local_notifications 초기화
  createForegroundListener(); // FCM 리스너 설정

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
    createForegroundListener(context);
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

  void createForegroundListener(BuildContext context) {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // 수신된 메시지가 알림인지 확인
    if (message.notification != null) {
      // 메시지의 title과 body를 Dialog로 표시
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(message.notification!.title ?? 'Notification'),
            content: Text(message.notification!.body ?? 'No message body'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // 다이얼로그 닫기
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  });
}
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void initializeNotifications() {
  // Android 초기화 설정
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  // iOS 초기화 설정
  const DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings();

  // 공통 초기화 설정
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

void createForegroundListener() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // 수신된 메시지가 알림인지 확인
    if (message.notification != null) {
      // 로컬 알림 표시
      _showNotification(
          message.notification!.title, message.notification!.body);
    }
  });
}

Future<void> _showNotification(String? title, String? body) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'your_channel_id', // 채널 ID
    'your_channel_name', // 채널 이름
    importance: Importance.max,
    priority: Priority.high,
    showWhen: false,
  );

  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0, // 알림 ID (중복되지 않게 설정)
    title, // 알림 제목
    body, // 알림 내용
    platformChannelSpecifics, // 알림 세부 설정
  );
}
