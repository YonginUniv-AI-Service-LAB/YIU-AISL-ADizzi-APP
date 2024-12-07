import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<int> uploadImage(String localPath) async {
  print("업로드 시작: $localPath");
  final image = await File(localPath);

  print("파일 읽기 완료: ${image.path}");

  var request = http.MultipartRequest('POST', Uri.parse('http://52.78.164.15:8080/api/image'));
  request.files.add(await http.MultipartFile.fromPath('image', image.path));
  print("MultipartRequest에 파일 추가 완료");

  // 요청의 헤더 및 파일 내용 출력
  print("요청 URL: ${request.url}");
  print("요청 메서드: ${request.method}");
  print("헤더: ${request.headers}");
  print("파일: ${request.files}");

  try {
    final response = await request.send();
    print("서버에 요청 전송 완료. 응답 상태 코드: ${response.statusCode}");

    if (response.statusCode == 200) {
      // 서버의 응답 본문을 읽어오기
      final responseBody = await response.stream.bytesToString();
      print("응답 본문: $responseBody");
      // 응답 본문을 int로 변환하여 반환
      return int.parse(responseBody); // 숫자형으로 변환
    } else {
      print("업로드 실패, 응답 상태 코드: ${response.statusCode}");
      return 0;
    }
  } catch (e) {
    print("업로드 중 오류 발생: $e");
    return 0;
  }
}