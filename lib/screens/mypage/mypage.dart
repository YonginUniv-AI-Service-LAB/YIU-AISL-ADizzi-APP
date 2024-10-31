import 'package:flutter/material.dart';

import '../../widgets/delete_confirmation_dialog.dart';
import '../changePwd/change_pwd_screen.dart';
import '../signIn/signIn_screen.dart';


class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        title: const Text(
          '마이 페이지',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 프로필 섹션
            const Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 25),
                Text(
                  '아이디',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF595959),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(),

            // 계정 섹션
            const SizedBox(height: 16),
            const Text(
              '계정',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.lock_reset),
              title: const Text('비밀번호 변경'),
              onTap: () {
                Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context) => const ChangePwd(),
                ));
                // 비밀번호 재설정 화면으로 이동
              },
            ),
            const SizedBox(height: 10),

            // 기타 섹션
            const SizedBox(height: 16),
            const Text(
              '기타',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('로그아웃'),
              onTap: () {
                Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context) => const SignIn(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_off),
              title: const Text('회원탈퇴'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const DeleteConfirmationDialog();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}