import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yiu_aisl_adizzi_app/service/service.dart';

Future<http.Response> containerDelete(int roomId, int containerId, String token) async {
  final String endpoint = '/room/$roomId/container/$containerId';
  final String uri = '$BASE_URL$endpoint';

  try {
    // 토큰에서 accessToken 추출
    final Map<String, dynamic> tokenMap = json.decode(token);
    final String accessToken = tokenMap['accessToken'];

    // DELETE 요청
    final response = await http.delete(
      Uri.parse(uri),
      headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    print('container DELETE 요청 성공');
    return response;
  } catch (e) {
    print('예외 발생: $e');
    throw Exception('서버와의 연결에 실패했습니다.');
  }
}
