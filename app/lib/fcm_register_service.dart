import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_fcm_sample/consts.dart';
import 'package:flutter_fcm_sample/dto/fcm_register_dto.dart';

class FCMRegisterService {
  final Dio dio = Dio(); // Dio instance

  Future<void> registerFCMToken() async {
    FirebaseMessaging messaging = await FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    String? fcmToken = await messaging.getToken();

    if (fcmToken != null) {
      await _sendFCMTokenToServer(fcmToken);
    } else {
      print('Failed to get FCM token');
    }
  }

  Future<void> _sendFCMTokenToServer(String token) async {
    const String url = '${SERVER_URL}/accounts/users/1/notification-settings';

    FCMRegisterReqeustDTO requestDTO = FCMRegisterReqeustDTO(fcmKey: token);

    try {
      Response response = await dio.post(
        url,
        data: requestDTO.toJson(), 
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 201) {
        debugPrint('FCM token registered successfully.');
      } else {
        debugPrint('Failed to register FCM token: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error during FCM registration: $e');
    }
  }
}