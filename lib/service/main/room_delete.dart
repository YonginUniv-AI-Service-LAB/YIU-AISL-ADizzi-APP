import 'dart:convert';
import 'package:http/http.dart' as http;

Future<http.Response> room(int roomId,String token ) async{
  final String baseUrl = 'http://3.38.162.253:8080/api';
  final String endpoint = '/room/$roomId';
  final String uri = '$baseUrl$endpoint';

  try {
    final response = await http.delete(
      Uri.parse(uri),
      headers: {
       'accept' : '*/*',
        'Authorization': 'Bearer $token',
      },
    );

    return response;
  } catch (e) {
    print('예외 발생: $e');
    throw Exception('서버와의 연결에 실패했습니다.');
  }
}
