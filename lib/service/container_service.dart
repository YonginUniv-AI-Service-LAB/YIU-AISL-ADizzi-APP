import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/service/service.dart';
import 'package:yiu_aisl_adizzi_app/utils/model.dart';
import 'package:http/http.dart' as http;
import 'package:yiu_aisl_adizzi_app/utils/show_dialog.dart';

// 수납장 목록 요청
Future<List<ContainerModel>> getContainers(BuildContext context, {required String sortBy, required int roomId}) async {
  final String url = '$BASE_URL/room/${roomId}/container?sortBy=${sortBy}'; // 기본 URL에 로그인 엔드포인트 추가
  String? accessToken = await storage.read(key: "accessToken");
  // 요청 헤더 설정
  Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8",
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
    );
    // 서버 응답 판별부
    if (response.statusCode == 200) {
      print('수납장 목록 요청 성공: ${utf8.decode(response.bodyBytes)}');
      // 성공 시 동작
      List<ContainerModel> data = (jsonDecode(utf8.decode(response.bodyBytes)) as List)
          .map<ContainerModel>((json) => ContainerModel.fromJson(json))
          .toList();
      return data;
    } else {
      // 에러 코드 출력
      final errorResponse = jsonDecode(utf8.decode(response.bodyBytes));
      print('수납장 목록 요청 실패: ${errorResponse['message']}');
      // accessToken 만료 시 처리
      if (errorResponse['code'] == "E103") {
        // 새로운 accessToken 발급
        String? newAccessToken = await refreshAccessToken(context);
        if (newAccessToken != null) {
          // 새로운 accessToken으로 다시 요청
          return await getContainers(context, sortBy: sortBy, roomId: roomId); // 재호출
        } else {
          showErrorDialog(context, '토큰 갱신에 실패했습니다.');
        }
      } else {
        // 토큰 이외의 오류
        showErrorDialog(context, errorResponse['message']);
      }
      throw Exception(errorResponse['message']);
    }
  } catch (e) {
    print('예외 발생: $e');
    throw Exception('서버와의 연결에 실패했습니다.');
  }
}

// 수납장 생성 요청
Future<void> createContainer(BuildContext context, {required String title, required int roomId, required int imageId}) async {
  final String url = '$BASE_URL/room/$roomId/container'; // 기본 URL에 로그인 엔드포인트 추가
  String? accessToken = await storage.read(key: "accessToken");
  // 요청 헤더 설정
  Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8",
  };
  // Request body에 담을 data  ( 'email', 'password' 자리가 변수 )
  final Map<String, dynamic> data = {
    "title": title,
    "imageId": imageId,
  };
  // accessToken이 존재하는 경우 Authorization 헤더 추가
  if (accessToken != null) {
    headers["Authorization"] = "Bearer $accessToken";
  }
  try {
    // 요청 보내는 부분
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(data),
    );
    // 서버 응답 판별부
    if (response.statusCode == 200) {
      print('수납장 생성 성공: ${utf8.decode(response.bodyBytes)}');
      return;
    } else {
      // 에러 코드 출력
      final errorResponse = jsonDecode(utf8.decode(response.bodyBytes));
      print('수납장 생성 실패: ${errorResponse['message']}');
      // accessToken 만료 시 처리
      if (errorResponse['code'] == "E103") {
        // 새로운 accessToken 발급
        String? newAccessToken = await refreshAccessToken(context);
        if (newAccessToken != null) {
          // 새로운 accessToken으로 다시 요청
          return await createContainer(context, title: title, roomId: roomId, imageId: imageId); // 재호출
        } else {
          showErrorDialog(context, '토큰 갱신에 실패했습니다.');
        }
      } else {
        // 토큰 이외의 오류
        showErrorDialog(context, errorResponse['message']);
      }
      throw Exception(errorResponse['message']);
    }
  } catch (e) {
    print('예외 발생: $e');
    throw Exception('서버와의 연결에 실패했습니다.');
  }
}

// 수납장 수정 요청
Future<void> editContainer(BuildContext context, {required int containerId, String? title, int? imageId, int? roomId = 1}) async {
  if (title == null) {return;}
  final String url = '$BASE_URL/room/$roomId/container/$containerId '; // 기본 URL에 로그인 엔드포인트 추가
  String? accessToken = await storage.read(key: "accessToken");
  // 요청 헤더 설정
  Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8",
  };
  // Request body에 담을 data  ( 'email', 'password' 자리가 변수 )
  final Map<String, dynamic> data = {
    "title": title,
    "imageId": imageId
  };
  // accessToken이 존재하는 경우 Authorization 헤더 추가
  if (accessToken != null) {
    headers["Authorization"] = "Bearer $accessToken";
  }
  try {
    // 요청 보내는 부분
    final response = await http.put(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(data),
    );
    // 서버 응답 판별부
    if (response.statusCode == 200) {
      print('수납장 수정 성공: ${utf8.decode(response.bodyBytes)}');
      // 성공 시 동작
      return;
    } else {
      // 에러 코드 출력
      final errorResponse = jsonDecode(utf8.decode(response.bodyBytes));
      print('수납장 수정 실패: ${errorResponse['message']}');
      // accessToken 만료 시 처리
      if (errorResponse['code'] == "E103") {
        // 새로운 accessToken 발급
        String? newAccessToken = await refreshAccessToken(context);
        if (newAccessToken != null) {
          // 새로운 accessToken으로 다시 요청
          return await editContainer(context, containerId: containerId, title: title, imageId: imageId, roomId: roomId); // 재호출
        } else {
          showErrorDialog(context, '토큰 갱신에 실패했습니다.');
        }
      } else {
        // 토큰 이외의 오류
        showErrorDialog(context, errorResponse['message']);
      }
      throw Exception(errorResponse['message']);
    }
  } catch (e) {
    print('예외 발생: $e');
    throw Exception('서버와의 연결에 실패했습니다.');
  }
}

// 수납장 삭제 요청
Future<void> deleteContainer(BuildContext context, {required int containerId, int? roomId = 1}) async {
  final String url = '$BASE_URL/room/$roomId/container/$containerId'; // 기본 URL에 로그인 엔드포인트 추가
  String? accessToken = await storage.read(key: "accessToken");
  // 요청 헤더 설정
  Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8",
  };
  // accessToken이 존재하는 경우 Authorization 헤더 추가
  if (accessToken != null) {
    headers["Authorization"] = "Bearer $accessToken";
  }
  try {
    // 요청 보내는 부분
    final response = await http.delete(
      Uri.parse(url),
      headers: headers,
    );
    // 서버 응답 판별부
    if (response.statusCode == 200) {
      print('수납장 삭제 성공: ${utf8.decode(response.bodyBytes)}');
      // 성공 시 동작
      return;
    } else {
      // 에러 코드 출력
      final errorResponse = jsonDecode(utf8.decode(response.bodyBytes));
      print('수납장 삭제 실패: ${errorResponse['message']}');
      // accessToken 만료 시 처리
      if (errorResponse['code'] == "E103") {
        // 새로운 accessToken 발급
        String? newAccessToken = await refreshAccessToken(context);
        if (newAccessToken != null) {
          // 새로운 accessToken으로 다시 요청
          return await deleteContainer(context, containerId: containerId, roomId: roomId); // 재호출
        } else {
          showErrorDialog(context, '토큰 갱신에 실패했습니다.');
        }
      } else {
        // 토큰 이외의 오류
        showErrorDialog(context, errorResponse['message']);
      }
      throw Exception(errorResponse['message']);
    }
  } catch (e) {
    print('예외 발생: $e');
    throw Exception('서버와의 연결에 실패했습니다.');
  }
}