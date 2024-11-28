import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../service/main/room_get.dart'; // roomGet 함수를 가져옵니다.
import '../utils/token.dart';

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
}
