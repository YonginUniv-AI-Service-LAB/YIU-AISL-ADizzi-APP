import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yiu_aisl_adizzi_app/utils/constants.dart';

Future<http.Response> roomUpdate(String title, String token, int roomId) async {
  final String endpoint = '/room/$roomId';
  final String uri = '$BASE_URL$endpoint';

  try {
    final Map<String, dynamic> tokenMap = json.decode(token);
    final String accessToken = tokenMap['accessToken']; // accessToken만 추출
    final Map<String, dynamic> requestData = {
      'title': title,
    };

    final response = await http.put(
      Uri.parse(uri),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
        'accept': '*/*',
      },
      body: jsonEncode(requestData),
    );
    print('API room update 호출 완료');

    return response;
  } catch (e) {
    print('예외 발생: $e');
    throw Exception('서버와의 연결에 실패했습니다.');
  }
}
