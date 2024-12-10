import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:yiu_aisl_adizzi_app/service/service.dart';
import 'package:http/http.dart' as http;

// 로그인 응답을 저장하는 함수
Future<void> _saveLoginResponse(String responseBody) async {
  final Map<String, dynamic> responseData = jsonDecode(responseBody);

  // 토큰 및 사용자 정보를 저장
  await storage.write(key: 'accessToken', value: responseData['accessToken']);
  await storage.write(key: 'refreshToken', value: responseData['refreshToken']);
  await storage.write(key: 'email', value: responseData['email']);

  print('로그인 응답 저장 완료');
}

Future<bool> isAccessToken() async{
  String? accessToken = await storage.read(key: "accessToken");
  if ( accessToken == null ){
    return false;
  }
  return true;
}

// 로그아웃 사용자 데이터 삭제
Future<void> _logout() async {
  await storage.deleteAll(); // 모든 데이터 삭제
  print('로그아웃 : 로그인 사용자 데이터 삭제');
}

// 로그인 요청을 처리하는 함수
Future<void> loginUser(BuildContext context, {
  required String email,
  required String password,
}) async {
  final String url = '$BASE_URL/login'; // 기본 URL에 로그인 엔드포인트 추가
  final Map<String, dynamic> data = {
    "email": email,
    "password": password,
  };
  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      print('로그인 성공: ${utf8.decode(response.bodyBytes)}');
      // 응답 데이터를 저장하는 함수 호출
      await _saveLoginResponse(utf8.decode(response.bodyBytes));
      return;
    } else {
      final errorResponse = jsonDecode(utf8.decode(response.bodyBytes));
      print('로그인 실패: ${errorResponse['message']}');
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorResponse['message'])),
        );
      throw Exception(errorResponse['message']);
    }
  } catch (e) {
    print('예외 발생: $e');
    throw Exception('서버와의 연결에 실패했습니다.');
  }
}

// 회원탈퇴 요청을 처리하는 함수
Future<void> deleteUser(BuildContext context) async {
  final String url = '$BASE_URL/user'; // 기본 URL에 로그인 엔드포인트 추가
  String? accessToken = await storage.read(key: "accessToken");
  if(accessToken == null) {
    return;
  }
  try {
    final response = await http.delete(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "Authorization": "Bearer $accessToken", // accessToken 추가
      },
    );

    if (response.statusCode == 200) {
      print('회원탈퇴 성공: ${utf8.decode(response.bodyBytes)}');
      // 응답 데이터를 저장하는 함수 호출
      await _logout();
      return;
    } else {
      final errorResponse = jsonDecode(utf8.decode(response.bodyBytes));
      print('회원탈퇴 실패: ${errorResponse['message']}');
      // accessToken 만료 시 처리
      if (errorResponse['code'] == "E103") {
        // 새로운 accessToken 발급
        String? newAccessToken = await refreshAccessToken(context);
        if (newAccessToken != null) {
          // 새로운 accessToken으로 다시 회원탈퇴 요청
          await deleteUser(context); // 재호출
          return;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('토큰 갱신에 실패했습니다.')),
          );
        }
      } else {
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

// 회원가입 요청을 처리하는 함수
Future<void> signUp(BuildContext context, {
  required String email,
  required String password,
}) async {
  final String url = '$BASE_URL/signUp'; // 기본 URL에 회원가입 엔드포인트 추가
  // 요청 데이터 생성
  final Map<String, dynamic> data = {
    "email": email,
    "password": password,
  };
  try {
    // POST 요청 보내기
    final response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json", // JSON 형식으로 전송
      },
      body: jsonEncode(data), // Map을 JSON으로 변환
    );
    // 응답 처리
    if (response.statusCode == 200) {
      // 성공적으로 회원가입 처리
      print('회원가입 성공: ${utf8.decode(response.bodyBytes)}');
      return; // 성공 시 추가 처리 필요 시 반환
    } else {
      final errorResponse = jsonDecode(utf8.decode(response.bodyBytes));
      print('회원가입 실패: ${errorResponse['message']}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorResponse['message'])),
      );
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorResponse['message'])),
        );
      throw Exception('회원가입 실패: ${errorResponse['message']}');
    }
  } catch (e) {
    print('예외 발생: $e');
    throw Exception('서버와의 연결에 실패했습니다.');
  }
}

// 인증메일 전송 요청을 처리하는 함수
Future<String> sendMail(BuildContext context, {
  required String email,
}) async {
  final String url = '$BASE_URL/mail'; // 기본 URL에 로그인 엔드포인트 추가
  final Map<String, dynamic> data = {
    "email": email,
  };
  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      String data = utf8.decode(response.bodyBytes);
      print('인증메일 전송 성공: $data');
      return data;
    } else {
      final errorResponse = jsonDecode(utf8.decode(response.bodyBytes));
      print('인증메일 전송 실패: ${errorResponse['message']}');
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorResponse['message'])),
        );
      throw Exception(errorResponse['message']);
    }
  } catch (e) {
    print('예외 발생: $e');
    throw Exception('서버와의 연결에 실패했습니다.');
  }
}

// 비밀번호 재설정 요청을 처리하는 함수
Future<void> changePassword(BuildContext context, {
  required String email,
  required String password,
}) async {
  final String url = '$BASE_URL/user'; // 기본 URL에 회원가입 엔드포인트 추가
  // 요청 데이터 생성
  final Map<String, dynamic> data = {
    "email": email,
    "password": password,
  };
  try {
    // POST 요청 보내기
    final response = await http.put(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json", // JSON 형식으로 전송
      },
      body: jsonEncode(data), // Map을 JSON으로 변환
    );
    // 응답 처리
    if (response.statusCode == 200) {
      // 성공적으로 회원가입 처리
      print('비밀번호 재설정 성공: ${utf8.decode(response.bodyBytes)}');
      return; // 성공 시 추가 처리 필요 시 반환
    } else {
      final errorResponse = jsonDecode(utf8.decode(response.bodyBytes));
      print('비밀번호 재설정 실패: ${errorResponse['message']}');
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorResponse['message'])),
        );
      throw Exception('비밀번호 재설정 실패: ${errorResponse['message']}');
    }
  } catch (e) {
    print('예외 발생: $e');
    throw Exception('서버와의 연결에 실패했습니다.');
  }
}