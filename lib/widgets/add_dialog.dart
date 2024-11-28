import 'dart:convert'; // UTF-8 인코딩을 위해 import합니다.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utils/token.dart';
import '../service/main/room_post.dart';

class AddDialog extends StatefulWidget {
  final String? initialTitle; // 기존 방 이름을 받기 위한 매개변수 추가

  const AddDialog({super.key, this.initialTitle});

  @override
  _AddDialogState createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  late TextEditingController _roomTitleController;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _roomTitleController = TextEditingController(text: widget.initialTitle ?? '');
  }

  void _roomAdd() async {
    final String title = _roomTitleController.text.trim();

    if (title.isEmpty) {
      _setError("방을 입력해주세요");
      return;
    }

    try {
      final token = await getToken();
      final response = await roomPost(title, token!);

      // 상태 코드와 응답 본문 출력
      print('Status Code: ${response.statusCode}');
      String decodedResponse = utf8.decode(response.bodyBytes); // UTF-8로 디코딩
      print('Response Body: $decodedResponse');

      if (response.statusCode == 200) {
        Navigator.of(context).pop(title); // 수정된 방 이름을 반환합니다.
      } else if (response.statusCode == 400) {
        final responseBody = json.decode(decodedResponse);
        if (responseBody['code'] == 'E801') {
          _setError('이미 사용 중인 방 이름입니다. 다른 이름을 사용해 주세요.');
        } else {
          _setError('방 등록에 실패했습니다. 다시 시도해주세요. 상태 코드: ${response.statusCode}');
        }
      } else {
        _setError('방 등록에 실패했습니다. 다시 시도해주세요. 상태 코드: ${response.statusCode}');
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

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Colors.black12, width: 1),
      ),
      backgroundColor: Colors.white,
      title: const Text(
        '방 이름',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _roomTitleController,
            decoration: InputDecoration(
              hintText: '방 이름을 입력하세요',
              hintStyle: TextStyle(color: Colors.black38, fontSize: 14),
              contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black12),
              ),
            ),
            textAlignVertical: TextAlignVertical.center,
          ),
          if (_errorMessage.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
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
                onPressed: _roomAdd,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  '등록',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
