import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yiu_aisl_adizzi_app/utils/constants.dart';

Future<http.Response> room(String title,String token,String sortBy ) async{
  final String baseUrl = 'http://3.38.162.253:8080/api';
  final String endpoint = '/room';
  final String uri = '$BASE_URL$endpoint?sortBy=$sortBy';

  try {

    final response = await http.get(
      Uri.parse(uri),
      headers: {
        'Authorization' : 'Bearer $token',
        'accept': '*/*',
      },

    );

    return response;
  } catch (e) {
    print('예외 발생: $e');
    throw Exception('서버와의 연결에 실패했습니다.');
  }
}