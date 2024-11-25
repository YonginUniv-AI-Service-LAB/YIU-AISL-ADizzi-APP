import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:yiu_aisl_adizzi_app/utils/constants.dart';

final FlutterSecureStorage storage = FlutterSecureStorage();

Future<http.Response> signIn(String email, String password) async {
  final String baseUrl = 'http://52.78.164.15:8080/api';
  final String endpoint = '/login';
  final String uri = '$BASE_URL$endpoint';

  try {
    final Map<String, dynamic> requestData = {
      'email': email,
      'password': password,
    };

    final response = await http.post(
      Uri.parse(uri),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestData),
    );

    return response;
  } catch (e) {
    print('예외 발생: $e');
    throw Exception('서버와의 연결에 실패했습니다.');
  }
}
