import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import '../../utils/constants.dart'; // 파일 이름을 처리하는 라이브러리

Future<int> imagePost(String token, File imageFile) async {
  final String endpoint = '/api/image'; // 이미지 등록 API 엔드포인트
  final String uri = '$BASE_URL$endpoint';

  try {
    // JWT 토큰에서 accessToken 추출
    final Map<String, dynamic> tokenMap = json.decode(token);
    final String accessToken = tokenMap['accessToken'];

    // 이미지 파일 이름을 추출
    final String image = basename(imageFile.path);

    // multipart 요청을 위해 MultipartRequest 사용
    var request = http.MultipartRequest('POST', Uri.parse(uri))
      ..headers['Authorization'] = 'Bearer $accessToken'
      ..headers['accept'] = '*/*'
      ..files.add(await http.MultipartFile.fromPath('image', imageFile.path));

    // 요청 전송
    var response = await request.send();

    // 응답 받기
    if (response.statusCode == 200) {
      // 응답 본문을 추출
      final responseBody = await response.stream.bytesToString();

      // 응답이 JSON 형식일 경우, imageId 추출
      final Map<String, dynamic> responseJson = json.decode(responseBody);
      final int imageId = responseJson['imageId'];

      print('이미지 업로드 성공, imageId: $imageId');

      return imageId; // imageId 반환
    } else {
      print('이미지 업로드 실패: ${response.statusCode}');
      return -1; // 실패 시 -1 반환
    }
  } catch (e) {
    print('예외 발생: $e');
    throw Exception('이미지 업로드 중 오류가 발생했습니다.');
  }
}
