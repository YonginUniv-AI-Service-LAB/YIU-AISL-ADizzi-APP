import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/screens/user/login_screen.dart';
import 'package:yiu_aisl_adizzi_app/service/service.dart';
import 'package:yiu_aisl_adizzi_app/service/user_service.dart';

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
              if (!await isAccessToken()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('로그인이 필요합니다.')),
                );
                return;
              }
              await deleteUser(context);
              logout();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
                    (Route<dynamic> route) => false, // 모든 이전 화면을 제거
              );
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
