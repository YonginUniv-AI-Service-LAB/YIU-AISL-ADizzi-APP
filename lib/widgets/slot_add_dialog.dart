import 'package:flutter/material.dart';

class SlotAddDialog extends StatelessWidget {
  final void Function(String)? onConfirm; // 입력 값 전달 콜백
  const SlotAddDialog({this.onConfirm, super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController(); // 입력 값 제어

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Colors.black12, width: 1),
      ),
      backgroundColor: Colors.white,
      title: const Text(
        '수납칸 이름',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
      content: SizedBox(
        height: 35,
        child: TextField(
          controller: textController, // 입력 값을 관리
          decoration: const InputDecoration(
            hintText: '수납칸 이름을 입력하세요.',
            hintStyle: TextStyle(
              color: Colors.black38,
              fontSize: 14,
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
            ),
          ),
          textAlignVertical: TextAlignVertical.center,
        ),
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // 다이얼로그 닫기
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
                onPressed: () {
                  if (onConfirm != null) {
                    onConfirm!(textController.text); // 입력 값 전달
                  }
                  Navigator.of(context).pop(); // 다이얼로그 닫기
                },
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
