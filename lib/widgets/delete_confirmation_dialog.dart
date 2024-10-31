import 'package:flutter/material.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  const DeleteConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        '정말 탈퇴하시겠어요?',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),

      content: const Text('탈퇴 버튼 선택 시, \n계정은 삭제되며 복구되지 않습니다.'),

      actions: [
        TextButton(
          onPressed: (){
            Navigator.of(context).pop();  //다이얼로그 닫음
          },
          child: const Text('취소'),
        ),

        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
          ),

          onPressed: () {
            // 회원 탈퇴 로직 추가
            Navigator.of(context).pop();
          },
          child: const Text('탈퇴'),
        ),
      ],
    );
  }
}