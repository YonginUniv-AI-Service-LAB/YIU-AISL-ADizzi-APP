import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:yiu_aisl_adizzi_app/screens/user/login_screen.dart';
import 'package:yiu_aisl_adizzi_app/service/user_service.dart';
import 'package:yiu_aisl_adizzi_app/utils/model.dart';

// API URL을 하나의 변수로 저장
const String BASE_URL = 'http://52.78.164.15:8080/api';
final storage = FlutterSecureStorage(); // FlutterSecureStorage 인스턴스 생성

// 로그인 여부 확인
Future<bool> isAccessToken() async{
  String? accessToken = await storage.read(key: "accessToken");
  if ( accessToken == null ){
    return false;
  }
  return true;
}

Future<String> getUserEmail() async{
  String? email = await storage.read(key: "email");
  if ( email == null ){
    return '이메일 조회 오류';
  }
  return email;
}

// 액세스 토큰 재발급
Future<String?> refreshAccessToken(BuildContext context) async {
  final String url = '$BASE_URL/refreshAccessToken'; // 토큰 갱신 엔드포인트
  String? refreshToken = await FlutterSecureStorage().read(key: "refreshToken");

  if (refreshToken == null) {
    return null; // refreshToken이 없으면 null 반환
  }

  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "Authorization": "Bearer $refreshToken", // accessToken 추가
      },
    );
    // TODO: refreshToken 만료 시 로그아웃 만들어야함
    if (response.statusCode == 200) {
      String newAccessToken = utf8.decode(response.bodyBytes); // 응답이 문자열일 경우
      // 새로운 accessToken 저장
      await storage.write(key: "accessToken", value: newAccessToken);
      return newAccessToken; // 새로운 accessToken 반환
    } else {
      // 에러 코드 출력
      final errorResponse = jsonDecode(utf8.decode(response.bodyBytes));
      print('회원정보수정 실패: ${errorResponse['message']}');
      // accessToken 만료 시 처리
      if (errorResponse['code'] == "E104") {
        // 로그아웃
        logout();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('토큰이 만료되어 로그아웃됩니다.')),
        );
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginScreen()),
              (Route<dynamic> route) => false, // 모든 기존 라우트를 제거
        ).then((_) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        });
        // 페이지 이동
      }
      throw Exception(errorResponse['message']);
    }
  } catch (e) {
    print('예외 발생: $e');
    return null;
  }
}

/// http 요청 함수 기본 틀
Future<void> actionObject(BuildContext context) async {
  final String url = '$BASE_URL/user'; // 기본 URL에 로그인 엔드포인트 추가
  String? accessToken = await storage.read(key: "accessToken");
  // 요청 헤더 설정
  Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8",
  };
  // Request body에 담을 data  ( 'email', 'password' 자리가 변수 )
  final Map<String, dynamic> data = {
    "email": 'email',
    "password": 'password',
  };
  // accessToken이 존재하는 경우 Authorization 헤더 추가
  if (accessToken != null) {
    headers["Authorization"] = "Bearer $accessToken";
  }
  try {
    // 요청 보내는 부분
    final response = await http.get(
      Uri.parse(url),
      headers: headers,
      // body: jsonEncode(data),
    );
    // 서버 응답 판별부
    if (response.statusCode == 200) {
      print('회원탈퇴 성공: ${utf8.decode(response.bodyBytes)}');
      // 성공 시 동작
      // await _logout();
      return;
    } else {
      // 에러 코드 출력
      final errorResponse = jsonDecode(utf8.decode(response.bodyBytes));
      print('회원탈퇴 실패: ${errorResponse['message']}');
      // accessToken 만료 시 처리
      if (errorResponse['code'] == "E103") {
        // 새로운 accessToken 발급
        String? newAccessToken = await refreshAccessToken(context);
        if (newAccessToken != null) {
          // 새로운 accessToken으로 다시 요청
          // return await actionObject(context); // 재호출
          return;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('토큰 갱신에 실패했습니다.')),
          );
        }
      } else {
        // 토큰 이외의 오류
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorResponse['message'])),
        );
      }
      throw Exception(errorResponse['message']);
    }
  } catch (e) {
    print('예외 발생: $e');
    throw Exception('서버와의 연결에 실패했습니다.');
  }
}