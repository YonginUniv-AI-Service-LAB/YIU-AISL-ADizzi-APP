import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:yiu_aisl_adizzi_app/models/room.dart'; // Room 클래스 임포트
import '../provider/room_provider.dart';
import '../utils/token.dart';
import '../service/main/room_post.dart';

class AddDialog extends StatefulWidget {
  final String? initialTitle;
  final int? roomId;  // 수정할 방의 ID 추가
  final bool isEdit;

  AddDialog({this.initialTitle = '', this.roomId, required this.isEdit});

  @override
  _AddDialogState createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  late TextEditingController _roomTitleController;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _roomTitleController = TextEditingController(text: widget.initialTitle);
  }

  void _handleRoomSubmit() async {
    String title = _roomTitleController.text.trim();

    // Validate the title
    if (title.isEmpty) {
      _setError('방 이름을 입력해주세요');
      return;
    }

    try {
      if (widget.isEdit) {
        // Edit existing room
        RoomModel updatedRoom = RoomModel(title: title, roomId: widget.roomId);
        await Provider.of<RoomProvider>(context, listen: false).updateRoom(updatedRoom);
      } else {
        // Create new room
        RoomModel newRoom = RoomModel(title: title, roomId: null); // roomId는 null로 시작
        await Provider.of<RoomProvider>(context, listen: false).addRoom(newRoom);
      }

      // If the room is added or edited successfully, close the dialog
      Navigator.of(context).pop();
    } catch (e) {
      // If an error occurs, display the error message
      _setError('방 등록/수정에 실패했습니다. 다시 시도해주세요.');
    }
  }

  void _setError(String message) {
    setState(() {
      _errorMessage = message;
    });
  }

  void _resetError() {
    setState(() {
      _errorMessage = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Colors.black12, width: 1),
      ),
      backgroundColor: Colors.white,
      title: Text(
        widget.isEdit ? '방 수정' : '방 이름',
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _roomTitleController,
            decoration: InputDecoration(
              hintText: '방 이름을 입력하세요',
              hintStyle: const TextStyle(color: Colors.black38, fontSize: 14),
              contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black12),
              ),
            ),
            textAlignVertical: TextAlignVertical.center,
            onChanged: (text) {
              if (_errorMessage.isNotEmpty) {
                _resetError();
              }
            },
          ),
          if (_errorMessage.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                _errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            ),
        ],
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  _resetError();
                  Navigator.of(context).pop();
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.black),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  '취소',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                onPressed: _handleRoomSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  widget.isEdit ? '수정' : '등록',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
