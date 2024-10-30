
import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/screens/main/room_screen.dart';
import '../../widgets/link_label.dart';
import '../changePwd/change_pwd_screen.dart';
import '../signUp/signUp_screen.dart';
import '../../widgets/signIn_button.dart';
import '../../widgets/signIn_text_input.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const LogoImage(),
                const SizedBox(height: 24),
                const SignInTextInput(label: '이메일'),
                const SignInTextInput(label: '비밀번호'),
                SignInButton(
                  label: '로그인',
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Room()),
                    );
                  },
                ),
                const SizedBox(height: 16),
                const LinkLabel(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LogoImage extends StatelessWidget {
  const LogoImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25), // 25% 투명한 검정색
            blurRadius: 4, // 블러 정도
            spreadRadius: 0, // 퍼짐 정도
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const CircleAvatar(
        radius: 75,
        backgroundImage: AssetImage('assets/images/ADizziLogo.png'),
        backgroundColor: Colors.white,
      ),
    );
  }
}


