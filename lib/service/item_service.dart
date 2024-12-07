import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/service/service.dart';
import 'package:yiu_aisl_adizzi_app/utils/model.dart';
import 'package:http/http.dart' as http;

// 물건 목록 요청
Future<List<ItemModel>> getItems(BuildContext context, {required String sortBy, required int slotId, int? containerId = 1, int? roomId = 1}) async {
  final String url = '$BASE_URL/room/${roomId}/container/$containerId/slot/$slotId/item?sortBy=${sortBy}'; // 기본 URL에 로그인 엔드포인트 추가
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
      print('물건 목록 요청 성공: ${utf8.decode(response.bodyBytes)}');
      // 성공 시 동작
      List<ItemModel> data = (jsonDecode(utf8.decode(response.bodyBytes)) as List)
          .map<ItemModel>((json) => ItemModel.fromJson(json))
          .toList();
      return data;
    } else {
      // 에러 코드 출력
      final errorResponse = jsonDecode(utf8.decode(response.bodyBytes));
      print('물건 목록 요청 실패: ${errorResponse['message']}');
      // accessToken 만료 시 처리
      if (errorResponse['code'] == "E103") {
        // 새로운 accessToken 발급
        String? newAccessToken = await refreshAccessToken(context);
        if (newAccessToken != null) {
          // 새로운 accessToken으로 다시 요청
          return await getItems(context, sortBy: sortBy, roomId: roomId, slotId: slotId, containerId: containerId); // 재호출
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

// 물건 생성 요청
Future<void> createItem(BuildContext context, {
  required String title,
  required int slotId,
  int? containerId = 1,
  int? roomId = 1,
  required int imageId,
  required String detail,
  int? category
}) async {
  final String url = '$BASE_URL/room/$roomId/container/$containerId/slot/$slotId/item'; // 기본 URL에 로그인 엔드포인트 추가
  String? accessToken = await storage.read(key: "accessToken");
  // 요청 헤더 설정
  Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8",
  };
  // Request body에 담을 data  ( 'email', 'password' 자리가 변수 )
  final Map<String, dynamic> data = {
    "title": title,
    "imageId": imageId,
    "category": category,
    "detail": detail
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
      print('물건 생성 성공: ${utf8.decode(response.bodyBytes)}');
      return;
    } else {
      // 에러 코드 출력
      final errorResponse = jsonDecode(utf8.decode(response.bodyBytes));
      print('물건 생성 실패: ${errorResponse['message']}');
      // accessToken 만료 시 처리
      if (errorResponse['code'] == "E103") {
        // 새로운 accessToken 발급
        String? newAccessToken = await refreshAccessToken(context);
        if (newAccessToken != null) {
          // 새로운 accessToken으로 다시 요청
          return await createItem(context, title: title, roomId: roomId, imageId: imageId, containerId: containerId, slotId: slotId, detail: detail, category: category); // 재호출
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

// 물건 수정 요청
Future<void> editItem(BuildContext context, {
  required int itemId,
  int? slotId = 1,
  int? containerId = 1,
  String? title,
  int? imageId,
  int? category,
  String? detail,
  int? roomId = 1}) async {
  final String url = '$BASE_URL/room/$roomId/container/$containerId/slot/$slotId/item/$itemId '; // 기본 URL에 로그인 엔드포인트 추가
  String? accessToken = await storage.read(key: "accessToken");
  // 요청 헤더 설정
  Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8",
  };
  // Request body에 담을 data  ( 'email', 'password' 자리가 변수 )
  final Map<String, dynamic> data = {
    "title": title,
    "imageId": imageId,
    "category": category,
    "detail": detail
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
      print('물건 수정 성공: ${utf8.decode(response.bodyBytes)}');
      // 성공 시 동작
      return;
    } else {
      // 에러 코드 출력
      final errorResponse = jsonDecode(utf8.decode(response.bodyBytes));
      print('물건 수정 실패: ${errorResponse['message']}');
      // accessToken 만료 시 처리
      if (errorResponse['code'] == "E103") {
        // 새로운 accessToken 발급
        String? newAccessToken = await refreshAccessToken(context);
        if (newAccessToken != null) {
          // 새로운 accessToken으로 다시 요청
          return await editItem(context, containerId: containerId, title: title, imageId: imageId, roomId: roomId, slotId: slotId, itemId: itemId, category: category, detail: detail); // 재호출
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

// 물건 삭제 요청
Future<void> deleteItem(BuildContext context, {required int itemId, int? slotId = 1, int? containerId = 1, int? roomId = 1}) async {
  final String url = '$BASE_URL/room/$roomId/container/$containerId/slot/$slotId/item/$itemId'; // 기본 URL에 로그인 엔드포인트 추가
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
      print('물건 삭제 성공: ${utf8.decode(response.bodyBytes)}');
      // 성공 시 동작
      return;
    } else {
      // 에러 코드 출력
      final errorResponse = jsonDecode(utf8.decode(response.bodyBytes));
      print('물건 삭제 실패: ${errorResponse['message']}');
      // accessToken 만료 시 처리
      if (errorResponse['code'] == "E103") {
        // 새로운 accessToken 발급
        String? newAccessToken = await refreshAccessToken(context);
        if (newAccessToken != null) {
          // 새로운 accessToken으로 다시 요청
          return await deleteItem(context, containerId: containerId, roomId: roomId, slotId: slotId, itemId: itemId); // 재호출
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


// 물건 이동 요청
Future<void> moveItem(BuildContext context, {required int itemId, required int slotId, int? containerId = 1, int? roomId = 1}) async {
  final String url = '$BASE_URL/room/$roomId/container/$containerId/slot/$slotId/item/$itemId'; // 기본 URL에 로그인 엔드포인트 추가
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
    final response = await http.patch(
      Uri.parse(url),
      headers: headers,
    );
    // 서버 응답 판별부
    if (response.statusCode == 200) {
      print('물건 이동 성공: ${utf8.decode(response.bodyBytes)}');
      // 성공 시 동작
      return;
    } else {
      // 에러 코드 출력
      final errorResponse = jsonDecode(utf8.decode(response.bodyBytes));
      print('물건 이동 실패: ${errorResponse['message']}');
      // accessToken 만료 시 처리
      if (errorResponse['code'] == "E103") {
        // 새로운 accessToken 발급
        String? newAccessToken = await refreshAccessToken(context);
        if (newAccessToken != null) {
          // 새로운 accessToken으로 다시 요청
          return await moveItem(context, containerId: containerId, roomId: roomId, slotId: slotId, itemId: itemId); // 재호출
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

// 내 모든 물건 목록 요청
Future<List<ItemModel>> getAllItems(BuildContext context, {required String sortBy}) async {
  final String url = '$BASE_URL/items'; // 기본 URL에 로그인 엔드포인트 추가
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
      print('내 모든 물건 목록 요청 성공: ${utf8.decode(response.bodyBytes)}');
      // 성공 시 동작
      List<ItemModel> data = (jsonDecode(utf8.decode(response.bodyBytes)) as List)
          .map<ItemModel>((json) => ItemModel.fromJson(json))
          .toList();
      return data;
    } else {
      // 에러 코드 출력
      final errorResponse = jsonDecode(utf8.decode(response.bodyBytes));
      print('내 모든 물건 목록 요청 실패: ${errorResponse['message']}');
      // accessToken 만료 시 처리
      if (errorResponse['code'] == "E103") {
        // 새로운 accessToken 발급
        String? newAccessToken = await refreshAccessToken(context);
        if (newAccessToken != null) {
          // 새로운 accessToken으로 다시 요청
          return await getAllItems(context, sortBy: sortBy); // 재호출
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