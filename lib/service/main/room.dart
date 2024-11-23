import 'dart:convert';
import 'package:http/http.dart' as http;

Future<http.Response> room(String title ) async{
  final String baseUrl = 'http://3.38.162.253:8080/api';
  final String endpoint = '/room';
  final String uri = '$baseUrl$endpoint';

  try {
    final Map<String, dynamic> requestData = {
      'title': title,

    };

    final response = await http.post(
      Uri.parse(uri),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'accept': '*/*',
      },
      body: jsonEncode(requestData),
    );

    return response;
  } catch (e) {
    print('예외 발생: $e');
    throw Exception('서버와의 연결에 실패했습니다.');
  }
}
