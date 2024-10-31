import 'package:flutter/material.dart';
import '../../widgets/main_button.dart';
import '../../widgets/main_text_input.dart';
import '../signIn/signIn_screen.dart';


class ChangePwd extends StatelessWidget {
  const ChangePwd({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '비밀번호 재설정',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFF0F0F0),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(
              context,

            );
          },
        ),
      ),
      body: BackgroundContainer(
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
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
                    const GroupContainer(
                      child: Column(
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
            ],
          ),
        )

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
      height: double.infinity,
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
