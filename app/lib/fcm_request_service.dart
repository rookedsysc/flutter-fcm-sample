import 'package:dio/dio.dart';
import 'package:flutter_fcm_sample/consts.dart';

class FCMReqeustService {
  final Dio dio = Dio(); // Dio instance

  Future<void> sendFCMTokenToServer(String token) async {
    const String url = '${SERVER_URL}/test/users/1';

    }
}