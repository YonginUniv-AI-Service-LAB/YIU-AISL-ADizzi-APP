import 'package:flutter/material.dart';

import '../../widgets/main_button.dart';
import '../../widgets/main_text_input.dart';
import '../signIn/signIn_screen.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '회원가입',
          style: TextStyle(
            color: Colors.black, // 텍스트 색상: 검정색
            fontSize: 18,
            fontWeight: FontWeight.w600, // 볼드체 설정
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFF0F0F0), // 앱 바 배경색
        elevation: 0, // 그림자 제거
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black), // 아이콘 색상: 검정색
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
        ),
      ),

      body: BackgroundContainer(
        child: Padding(
          padding: const EdgeInsets.only(top:30, left: 15, right: 15),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const GroupContainer(
                      child: Column(
                        children: [
                          MainTextInput(
                            label: '이메일',
                            showCheck: false, // 인증 확인
                            showRequest: true,  // 인증 요청
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
                    const GroupContainer(
                      child: Column(
                        children: [
                          MainTextInput(
                            label: '비밀번호',
                            showCheck: false,
                            showRequest: false,
                            showIcon: true,
                          ),
                          MainTextInput(
                            label: '비밀번호 재입력',
                            showCheck: false,
                            showRequest: false,
                            showIcon: true,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    MainButton(
                      label: '회원가입',
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
            ],
          ),
        ),
      ),
    );
  }
}
class BackgroundContainer extends StatelessWidget {
  final Widget child;
  const BackgroundContainer({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF0F0F0),
      child: child,
    );
  }
}
class GroupContainer extends StatelessWidget {
  final Widget child;
  const GroupContainer({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 40),
      child: Center(child: child),
    );
  }
}