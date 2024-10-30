


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/changePwd/change_pwd_screen.dart';
import '../screens/signUp/signUp_screen.dart';

class LinkLabel extends StatelessWidget {
  const LinkLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignUp()),
            );
          },
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFF595959), width: 0.5),
              ),
            ),
            child: const Text(
              '회원 가입',
              style: TextStyle(
                color: Color(0xFF595959),
                fontSize: 18,
              ),
            ),
          ),
        ),
        const Text(
          ' / ',
          style: TextStyle(
            color: Color(0xFF595959),
            fontSize: 18,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChangePwd()),
            );
          },
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFF595959), width: 0.5),
              ),
            ),
            child: const Text(
              '비밀번호 찾기',
              style: TextStyle(
                color: Color(0xFF595959),
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],

    );
  }
}