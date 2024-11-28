import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../service/main/room_get.dart';
import '../utils/token.dart';
import '../service/main/room_delete.dart'; // roomDelete 함수가 있는 경로

class RoomProvider extends ChangeNotifier {
  List<String> _rooms = [];

  List<String> get rooms => _rooms;

  void addRoom(String title) {
    _rooms.add(title);
    notifyListeners();
  }

  void removeRoom(String title) {
    _rooms.remove(title);
    notifyListeners();
  }

  void updateRoom(int index, String newTitle) {
    if (index >= 0 && index < _rooms.length) {
      _rooms[index] = newTitle;
      notifyListeners();
    }
  }

  Future<void> fetchRooms() async {
    try {
      final token = await getToken();
      final response = await roomGet(token!, 'recent');

      if (response.statusCode == 200) {
        final List<dynamic> roomData = json.decode(response.body);
        _rooms = roomData.map((room) => room['title'].toString()).toList();
        notifyListeners();
      } else {
        throw Exception('방 목록을 가져오는 데 실패했습니다. 상태 코드: ${response.statusCode}');
      }
    } catch (e) {
      print('방 목록 가져오기 예외 발생: $e');
    }
  }

  // deleteRoom 메서드 추가
  Future<void> deleteRoom(BuildContext context, int roomId) async {
    try {
      final token = await getToken();
      final response = await roomDelete(roomId, token!); // roomDelete API 호출

      if (response.statusCode == 200) {
        // 성공적으로 삭제되면 방을 목록에서 제거
        _rooms.removeAt(roomId - 1);  // roomId가 1부터 시작하므로 인덱스 조정
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('방이 삭제되었습니다.')),
        );
      } else {
        throw Exception('방 삭제 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('방 삭제 예외 발생: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('방 삭제에 실패했습니다.')),
      );
    }
  }
}
