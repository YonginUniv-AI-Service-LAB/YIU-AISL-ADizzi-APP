import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yiu_aisl_adizzi_app/utils/constants.dart';

Future<http.Response> containerGet(String token,String sortBy, int roomId ) async{
  final String endpoint = '/room/$roomId/container';
  final String uri = '$BASE_URL$endpoint?sortBy=$sortBy';

  try {
    final Map<String, dynamic> tokenMap = json.decode(token);
    final accessToken = tokenMap['accessToken']; //accessToken만 추출
    final response = await http.get(
      Uri.parse(uri),
      headers: {
        'Authorization' : 'Bearer $accessToken',
        'accept': '*/*',
      },

    );
    print('api container get');
    print(response.body);
    return response;
  } catch (e) {
    print('예외 발생: $e');
    throw Exception('서버와의 연결에 실패했습니다.');
  }
}