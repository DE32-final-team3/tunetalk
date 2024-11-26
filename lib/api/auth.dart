import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Auth {
  static const _storage = FlutterSecureStorage();

  // 토큰 저장된 값 읽기
  static Future<String?> getAccessToken() async {
    return await _storage.read(key: 'access_token');
  }

  // 토큰 유효성 확인
  static Future<bool> validateToken(String token) async {
    try {
      String? serverIP = dotenv.env['SERVER_IP']!;
      var url = Uri.http(
        serverIP,
        '/api/user/validate',
      );

      var response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );

      return response.statusCode == 200; // 200이면 유효
    } catch (e) {
      print('Token validation error: $e');
      return false;
    }
  }

  // 토큰 삭제 (로그아웃 등)
  static Future<void> clearToken() async {
    await _storage.delete(key: 'access_token');
  }
}
