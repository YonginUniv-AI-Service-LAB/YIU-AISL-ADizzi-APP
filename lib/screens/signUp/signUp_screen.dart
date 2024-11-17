import 'package:flutter/material.dart';

import '../../widgets/main_button.dart';
import '../../widgets/main_text_input.dart';
import '../signIn/signIn_screen.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '회원가입',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFF0F0F0),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xFFF0F0F0),
          padding: EdgeInsets.all(width * 0.05),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: height * 0.04),
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
                padding: EdgeInsets.only(bottom: height * 0.04),
                child: const Column(
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
      ),
    );
  }
}
