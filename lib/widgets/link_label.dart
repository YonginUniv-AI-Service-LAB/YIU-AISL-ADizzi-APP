import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/user/change_pwd_screen.dart';
import '../screens/user/sign_up_screen.dart';

class LinkLabel extends StatelessWidget {
  const LinkLabel({super.key});

  // 공통 링크 생성 함수
  Widget _buildLink(BuildContext context, String text, Widget screen) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFF595959), width: 0.4),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Color(0xFF595959),
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLink(context, '회원 가입', SignUpScreen()), // 회원 가입 링크
        const Text(
          ' / ',
          style: TextStyle(
            color: Color(0xFF595959),
            fontSize: 13,
          ),
        ),
        _buildLink(context, '비밀번호 찾기', ChangePwdScreen()), // 비밀번호 찾기 링크
      ],
    );
  }
}
