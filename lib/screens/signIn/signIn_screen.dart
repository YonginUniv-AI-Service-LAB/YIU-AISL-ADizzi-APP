
import 'package:flutter/material.dart';
import '../../widgets/link_label.dart';
import '../../widgets/logo_image.dart';
import '../../widgets/signIn_button.dart';
import '../../widgets/signIn_text_input.dart';
import '../room/room_screen.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: height * 0.05),
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
                        MaterialPageRoute(builder: (context) =>const Room()),
                    );
                  },
                ),
                const SizedBox(height: 16),
                const LinkLabel(),
              ],
            ),
          ),
        ),
    );
  }
}



