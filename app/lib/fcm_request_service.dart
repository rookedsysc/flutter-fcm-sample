import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_fcm_sample/consts.dart';
import 'package:flutter_fcm_sample/dto/fcm_request_dto.dart';

class FCMReqeustService {
  final Dio dio = Dio(); // Dio instance

  Future<String> sendFCMTokenToServer() async {
    FirebaseMessaging messaging = await FirebaseMessaging.instance;

    String? token = await messaging.getToken();

    if(token == null) {
      return 'Failed to get FCM token';
    }


    const String url = '${SERVER_URL}/test/users/1';
    final dio = Dio();

    try {
      // FCM 요청 객체 생성
      final fcmRequest = FcmRequest(
        title: "FCM 알림 제목",
        body: "FCM 알림 내용",
        image: "https://example.com/image.jpg",
        data: {"key": "value"},
        target: NotificationTarget.ALL,
      );

      // 요청 본문 생성
      final requestBody = {
        ...fcmRequest.toJson(),
        "content": {}, // 빈 객체로 content 추가
      };

      // POST 요청 보내기
      final response = await dio.post(
        url,
        data: requestBody,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token", // FCM 토큰을 Authorization 헤더에 추가
          },
        ),
      );

      // 응답 처리
      if (response.statusCode == 201) {
        return 'FCM 토큰이 성공적으로 서버에 전송되었습니다.';
      } else {
        debugPrint('FCM 토큰 전송 실패. 상태 코드: ${response.statusCode}');
        return 'FCM 토큰 전송 실패. 상태 코드: ${response.statusCode}';
      }
    } catch (e) {
      debugPrint('FCM 토큰 전송 중 오류 발생: $e');
      return 'FCM 토큰 전송 중 오류 발생: $e';
    }
  }
}
