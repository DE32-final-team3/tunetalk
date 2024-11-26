import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserApi {
  static const _storage = FlutterSecureStorage();

  static Future<bool> loginApi(String email, String password) async {
    String? serverIP = dotenv.env['SERVER_IP']!;

    var url = Uri.http(
      serverIP, // 호스트 주소
      '/api/user/login', // 경로
    );

    var r = await http.post(
      url,
      headers: {'Content-type': 'application/x-www-form-urlencoded'},
      body: {
        'username': email,
        'password': password,
      },
      encoding: Encoding.getByName('utf-8'),
    ); // POST 요청 보내기

    var statuscode = r.statusCode;
    var body = jsonDecode(r.body);

    if (statuscode == 200) {
      await _storage.write(key: 'access_token', value: body['access_token']);
      print('로그인 성공');
      return true;
    } else {
      String errorMsg = body['message'] ?? '로그인 실패';
      print(errorMsg);
      return false;
    } // 응답의 상태 코드 반환
  }
}
