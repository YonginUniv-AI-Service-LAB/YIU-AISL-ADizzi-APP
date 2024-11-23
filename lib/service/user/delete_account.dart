import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../screens/login/login_screen.dart';

Future<http.Response> deleteAccount(BuildContext context, String token) async {
  final String baseUrl = 'http://3.38.162.253:8080/api';
  final String endpoint = '/user';
  final String uri = '$baseUrl$endpoint';

  try {
    /*
    {
  "accessToken": "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIyIiwiaWF0IjoxNzMyMzcyOTk2LCJleHAiOjE3MzIzNzQ3OTZ9",
  "refreshToken": "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIyIiwiaWF0IjoxNzMyMzcyOTk2LCJleHAiOjE3MzI5Nzc3OTZ9"
    }

     */
    final Map<String, dynamic> tokenMap = json.decode(token);
    final accessToken = tokenMap['accessToken']; //accessToken만 추출

    final response = await http.delete(
      Uri.parse(uri),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );
    if(response.statusCode == 200){
      print('회원탈퇴 성공하셨습니다. ');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    }
    return response;

  } catch (e) {
    print('예외 발생: $e');
    throw Exception('서버와의 연결에 실패했습니다.');
  }
}
