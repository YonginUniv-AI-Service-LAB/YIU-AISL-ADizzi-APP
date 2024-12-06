import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:yiu_aisl_adizzi_app/service/service.dart';
import 'package:yiu_aisl_adizzi_app/utils/model.dart';

class TreeProvider with ChangeNotifier {
  List<RoomModel> _rooms = [];

  List<RoomModel> get rooms => _rooms;

  // 트리구조 요청
  Future<void> fetchTree(BuildContext context) async {
    final String url = '$BASE_URL/tree'; // 기본 URL에 로그인 엔드포인트 추가
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
        print('트리구조 요청 성공: ${utf8.decode(response.bodyBytes)}');
        // 성공 시 동작
        List<dynamic> jsonList = jsonDecode(utf8.decode(response.bodyBytes));
        _rooms = jsonList.map((json) => RoomModel.fromJson(json)).toList();
        notifyListeners(); // 상태가 변경되었음을 알림
        return;
      } else {
        // 에러 코드 출력
        final errorResponse = jsonDecode(utf8.decode(response.bodyBytes));
        print('트리구조 요청 실패: ${errorResponse['message']}');
        // accessToken 만료 시 처리
        if (errorResponse['code'] == "E103") {
          // 새로운 accessToken 발급
          String? newAccessToken = await refreshAccessToken(context);
          if (newAccessToken != null) {
            // 새로운 accessToken으로 다시 요청
            return await fetchTree(context); // 재호출
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

  RoomModel? getRoomById(int roomId){
    for (var room in _rooms) {
      if (room.roomId == roomId) {
        return room;
      }
    }
    return null;
  }

  RoomModel? getRoomByContainerId(int containerId){
    for (var room in _rooms) {
      for (var container in room.containers) {
        if (container.containerId == containerId){
          return room;
        }
      }
    }
    return null;
  }

  RoomModel? getRoomBySlotId(int slotId) {
    for (var room in _rooms) {
      for (var container in room.containers) {
        for (var slot in container.slots) {
          if (slot.slotId == slotId) {
            return room; // 해당 slotId에 속한 room의 title 반환
          }
        }
      }
    }
    return null; // slotId에 해당하는 room이 없을 경우
  }

  ContainerModel? getContainerById(int containerId) {
    for (var room in _rooms) {
      for (var container in room.containers) {
        if (container.containerId == containerId) {
          return container; // 해당 slotId에 속한 room의 title 반환
        }
      }
    }
    return null; // slotId에 해당하는 room이 없을 경우
  }

  ContainerModel? getContainerBySlotId(int slotId) {
    for (var room in _rooms) {
      for (var container in room.containers) {
        for (var slot in container.slots) {
          if (slot.slotId == slotId) {
            return container; // 해당 slotId에 속한 room의 title 반환
          }
        }
      }
    }
    return null; // slotId에 해당하는 room이 없을 경우
  }

  SlotModel? getSlotById(int slotId) {
    for (var room in _rooms) {
      for (var container in room.containers) {
        for (var slot in container.slots) {
          if (slot.slotId == slotId) {
            return slot; // 해당 slotId에 속한 room의 title 반환
          }
        }
      }
    }
    return null; // slotId에 해당하는 room이 없을 경우
  }
}
