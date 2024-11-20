import 'package:flutter/material.dart';
import '../../widgets/main_button.dart';
import '../../widgets/main_text_input.dart';
import '../signIn/signIn_screen.dart';


class ChangePwd extends StatelessWidget {
  const ChangePwd({super.key});

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '비밀번호 재설정',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFF0F0F0),
      ),
      body: Container(
        color: const Color(0xFFF0F0F0),
        padding: EdgeInsets.all(width * 0.05),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: height * 0.05,top: 20),
              child: const Column(
                children: [
                  MainTextInput(
                    label: '이메일',
                    showCheck: false,
                    showRequest: true,
                    showIcon: false,
                  ),
                  MainTextInput(
                    label: '인증번호',
                    showCheck: true,
                    showRequest: false,
                    showIcon: false,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: height * 0.05),
              child: const Column(
                children: [
                  MainTextInput(
                    label: '새 비밀번호',
                    showCheck: false,
                    showRequest: false,
                    showIcon: true,
                  ),
                  MainTextInput(
                    label: '새 비밀번호 재입력',
                    showCheck: false,
                    showRequest: false,
                    showIcon: true,
                  ),
                ],
              ),
            ),
            MainButton(
              label: '로그인',
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SignIn()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
