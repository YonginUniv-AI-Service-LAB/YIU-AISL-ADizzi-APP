import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/utils/token.dart';
import '../service/user/delete_account.dart';

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
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('취소'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
          ),
          onPressed: () async {
            try{
              final token = await getToken();
              if (token == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('로그인이 필요합니다.')),
                );
                return;
              }
              await deleteAccount(context, token);
            }catch(e){
              throw Exception('서버와의 연결에 실패했습니다.');
            }
          },
          child: const Text('탈퇴'),
        ),
      ],
    );
  }
}
