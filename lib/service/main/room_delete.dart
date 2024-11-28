import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yiu_aisl_adizzi_app/utils/constants.dart';

Future<http.Response> roomDelete(int roomId,String token ) async{

  final String endpoint = '/room/$roomId';
  final String uri = '$BASE_URL$endpoint';

  try {
    final Map<String, dynamic> tokenMap = json.decode(token);
    final accessToken = tokenMap['accessToken']; //accessToken만 추출
    final response = await http.delete(
      Uri.parse(uri),
      headers: {
       'accept' : '*/*',
        'Authorization' : 'Bearer $accessToken',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    return response;
  } catch (e) {
    print('예외 발생: $e');
    throw Exception('서버와의 연결에 실패했습니다.');
  }
}
