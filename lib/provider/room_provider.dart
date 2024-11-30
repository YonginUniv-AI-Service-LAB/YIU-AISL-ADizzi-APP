import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/models/room.dart';
import '../service/main/room_get.dart';
import '../service/main/room_post.dart';
import '../service/main/room_update.dart';
import '../utils/token.dart';
import '../service/main/room_delete.dart';

class RoomProvider extends ChangeNotifier {
  List<RoomModel> _roomList = []; // 내부 저장을 위한 _roomList

  List<RoomModel> get roomList => _roomList;

  Future<void> addRoom(RoomModel room) async {
    try {
      final token = await getToken();
      final response = await roomPost(room, token!);
      print('상태코드: ${response.statusCode}');
      String decodedResponse = response.body;
      print('응답바디: $decodedResponse');

      if (response.statusCode == 200) {
        if (decodedResponse == 'success') {
          await getRoom();
        } else {
          throw Exception('방 추가 실패, 예상치 못한 응답: $decodedResponse');
        }
      } else {
        throw Exception('방 추가 실패, 상태 코드: ${response.statusCode}');
      }
    } catch (e) {
      print('방 추가 중 오류 발생: $e');
      throw Exception('방 추가 중 오류 발생: $e');
    }
  }

// 방 목록을 갱신하는 fetchRooms 함수
  Future<void> getRoom() async {
    try {
      final token = await getToken();
      final response = await roomGet(token!, 'recent');

      if (response.statusCode == 200) {
        final List<dynamic> roomData = json.decode(response.body);
        _roomList = roomData.map((room) {
          print(
              'Room title: ${room['title']}, Room ID: ${room['roomId']}');
          return RoomModel.fromJson(room);
        }).toList();
        notifyListeners();
      } else {
        throw Exception(
            'Failed to fetch rooms with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching rooms: $e');
      throw Exception('Error fetching rooms: $e');
    }
  }
  Future<void> deleteRoom(RoomModel room) async {
    try {
      if (room.roomId == null) {
        throw Exception('roomId is null');
      }
      final token = await getToken();
      final response = await roomDelete(room.roomId!, token!);

      if (response.statusCode == 200) {
        _roomList.removeWhere((r) => r.roomId == room.roomId);
        notifyListeners(); // UI 갱신
      } else {
        throw Exception(
            'Failed to delete room with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting room: $e');
      throw Exception('Error deleting room: $e');
    }
  }

  Future<void> updateRoom(RoomModel room) async {
    try {
      if (room.roomId == null) {
        throw Exception('roomId is null');
      }

      // Get the token
      final token = await getToken();
      final response = await roomUpdate(room.title, token!, room.roomId!);

      print('서버 응답: ${response.body}');

      // Check if the response status is successful
      if (response.statusCode == 200) {
        // Update the room in the local list
        final updatedRoom = room.changeRoom(title: room.title);  // Assuming title is the only field to update

        // Find the room index in the list and update it
        final index = _roomList.indexWhere((r) => r.roomId == room.roomId);
        if (index != -1) {
          _roomList[index] = updatedRoom;  // Update the room in the list
          notifyListeners(); // Notify listeners to update the UI
        }
      } else {
        throw Exception('Failed to update room with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating room: $e');
      throw Exception('Error updating room: $e');
    }
  }
}

