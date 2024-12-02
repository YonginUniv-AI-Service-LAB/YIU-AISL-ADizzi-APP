import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../utils/constants.dart';

Future<http.Response> containerPost(String title, String token, int roomId, int imageId) async {

  final String endpoint = '/room/$roomId/container';
  final String uri = '$BASE_URL$endpoint';

  try {
    final Map<String, dynamic> tokenMap = json.decode(token);
    final String accessToken = tokenMap['accessToken']; // accessToken만 추출
    final Map<String, dynamic> requestData = {
      'title': title,
      'imageId': imageId,
    };

    final response = await http.post(
      Uri.parse(uri),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json; charset=UTF-8',
        'accept': '*/*',
      },
      body: jsonEncode(requestData),
    );

    print('container post 성공');
    return response;
  } catch (e) {
    print('예외 발생: $e');
    throw Exception('서버와의 연결에 실패했습니다.');
  }
}
