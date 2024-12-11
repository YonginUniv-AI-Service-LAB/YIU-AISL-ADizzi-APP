import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/screens/user/login_screen.dart';
import 'package:yiu_aisl_adizzi_app/service/service.dart';
import 'package:yiu_aisl_adizzi_app/service/user_service.dart';
import '../../widgets/delete_confirmation_dialog.dart';
import 'change_pwd_screen.dart';



class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        title: const Text(
          '마이 페이지',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
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
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 프로필 섹션
             Row(
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
                // FutureBuilder로 이메일을 비동기적으로 가져오기
                FutureBuilder<String>(
                  future: getUserEmail(),
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text('로딩 중...');
                    } else if (snapshot.hasError) {
                      return const Text('이메일 조회 오류');
                    } else {
                      return Text(
                        snapshot.data ?? '이메일 없음',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF595959),
                        ),
                      );
                    }
                  },
                )
              ],
            ),
            const SizedBox(height: 20),


            // 계정 섹션
            const SizedBox(height: 16),
            const Text(
              '계정',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600,),
            ),
            const SizedBox(height: 10),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 7),
              leading: const Icon(Icons.lock_reset),

              title: const Text('비밀번호 변경',style: TextStyle(fontSize: 15),),
              onTap: () {
                Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context) => ChangePwdScreen(),
                ));
                // 비밀번호 재설정 화면으로 이동
              },
            ),
            const SizedBox(height: 10),

            // 기타 섹션
            const SizedBox(height: 16),
            const Text(
              '기타',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600,),
            ),
            const SizedBox(height: 10),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 7),
              leading: const Icon(Icons.logout),
              title: const Text('로그아웃',style: TextStyle(fontSize: 15),),
              onTap: () {
                logout();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                      (Route<dynamic> route) => false, // 모든 이전 화면을 제거
                );
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 7),
              leading: const Icon(Icons.person_off),
              title: const Text('회원탈퇴',style: TextStyle(fontSize: 15),),
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