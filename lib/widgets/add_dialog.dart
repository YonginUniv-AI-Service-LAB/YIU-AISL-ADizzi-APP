import 'dart:convert'; // UTF-8 인코딩을 위해 import합니다.
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utils/token.dart';
import '../service/main/room_post.dart';
import '../service/main/room_update.dart'; // 수정 API 추가

class AddDialog extends StatefulWidget {
  final String? initialTitle; // 초기 방 이름
  final int? roomId; // 방 ID (수정 시 필요)
  final bool isEdit; // 등록/수정을 구분

  const AddDialog({super.key, this.initialTitle, this.roomId, required this.isEdit});

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

  // 등록 및 수정 처리
  void _handleRoomSubmit() async {
    final String title = _roomTitleController.text.trim();

    if (title.isEmpty) {
      _setError("방 이름을 입력해주세요");
      return;
    }

    try {
      final token = await getToken();

      // 등록 또는 수정 API 호출
      final response = widget.isEdit
          ? await roomUpdate(title, token!, widget.roomId!) // 수정
          : await roomPost(title, token!); // 등록

      print('Status Code: ${response.statusCode}');
      String decodedResponse = utf8.decode(response.bodyBytes);
      print('Response Body: $decodedResponse');
      print('Updating roomId: ${widget.roomId}, title: $title');

      if (response.statusCode == 200) {
        _resetError();
        Navigator.of(context).pop(title); // 성공 시 모달 닫기 및 제목 반환
      } else {
        final responseBody = json.decode(decodedResponse);
        if (responseBody['code'] == 'E801') {
          _setError('이미 사용 중인 방 이름입니다.');
        } else {
          _setError('알 수 없는 오류가 발생했습니다.');
        }
      }
    } catch (e) {
      print('예외 발생: $e');
      _setError('서버와의 연결에 실패했습니다. 인터넷 연결을 확인해주세요.');
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
