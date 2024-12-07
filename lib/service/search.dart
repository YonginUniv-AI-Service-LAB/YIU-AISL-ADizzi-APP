import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/service/service.dart';
import 'package:yiu_aisl_adizzi_app/utils/model.dart';
import 'package:http/http.dart' as http;


// 물건 검색
Future<List<ItemModel>> getSearch(BuildContext context,{required  String query}) async {
  final String url = '$BASE_URL/search?query=$query';
  String? accessToken = await storage.read(key: "accessToken");

  Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8",
  };

  if (accessToken != null) {
    headers["Authorization"] = "Bearer $accessToken";
  }

  try {
    // 요청 보내는 부분
    final response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    // 서버 응답 판별부
    if (response.statusCode == 200) {
      print('서치 요청 성공: ${utf8.decode(response.bodyBytes)}');
      // 성공 시 동작
      List<ItemModel> data = (jsonDecode(utf8.decode(response.bodyBytes)) as List)
          .map<ItemModel>((json) => ItemModel.fromJson(json))
          .toList();
      return data;
    } else {
      // 에러 코드 출력
      final errorResponse = jsonDecode(utf8.decode(response.bodyBytes));
      print('응답 본문: ${utf8.decode(response.bodyBytes)}');
      print('검색 실패: ${errorResponse['message']}');

      // accessToken 만료 시 처리
      if (errorResponse['code'] == "E103") {
        // 새로운 accessToken 발급
        String? newAccessToken = await refreshAccessToken(context);
        if (newAccessToken != null) {
          // 새로운 accessToken으로 다시 요청
          return await getSearch(context, query: query); // 재호출
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
