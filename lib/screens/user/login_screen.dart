import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:yiu_aisl_adizzi_app/service/user_service.dart';
import '../../widgets/link_label.dart';
import '../../widgets/logo_image.dart';
import '../../widgets/login_button.dart';
import '../../widgets/login_text_input.dart';
import '../main/main_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  String _errorMessage = '';

  // 로그인 함수
  void _login() async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    // 이메일이 비어있는지 확인
    if (email.isEmpty) {
      _setError('이메일을 입력해주세요.');
      return;
    }

    // 이메일 형식 검증
    RegExp emailRegExp = RegExp(
      r"^(?!@)(?!.*@$)([a-zA-Z0-9._%+-]+)@([a-zA-Z0-9.-]+\.[a-zA-Z]{2,})$",
    );
    if (!emailRegExp.hasMatch(email)) {
      _setError('이메일 형식이 올바르지 않습니다.');
      return;
    }

    // 비밀번호가 비어있는지 확인
    if (password.isEmpty) {
      _setError('비밀번호를 입력해주세요.');
      return;
    }

    try {
      // 로그인 요청
      await loginUser(context, email: email, password: password);
    //   final response = await signIn(email, password);
    //   final errorResponse = jsonDecode(utf8.decode(response.bodyBytes));
    //
    //   if (response.statusCode == 200) {
    //     // 로그인 성공
    //     print('로그인 성공');
    //     final data = response.body; // 서버 응답 데이터 (예: 토큰)
    //     await _storage.write(key: "user_token", value: data);
    //     print(" $data");
    //
    //     _navigateToRoom();
    //   } else if (errorResponse['code'] == "E503") {
    //     _setError('회원가입을 해주세요');
    //   } else if (errorResponse['code'] == "E701") {
    //     _setError('비밀번호가 일치하지 않습니다..');
    //   } else if (response.statusCode == 404) {
    //     _setError('이메일이 존재하지 않습니다.');
    //   } else {
    //     _setError('로그인 실패. 다시 시도해주세요.');
    //   }
      _navigateToRoom();
    } catch (e) {
      print('서버 오류: $e');
      _setError('서버와의 연결에 실패했습니다. 인터넷 연결을 확인해주세요.');
    }
  }

  // 에러 메시지 설정
  void _setError(String message) {
    setState(() {
      _errorMessage = message;
    });
  }

  // 로그인 성공 시 화면 전환 함수
  void _navigateToRoom() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const LogoImage(),
              const SizedBox(height: 45),
              _buildEmailInput(),
              const SizedBox(height: 6),
              _buildPasswordInput(),
              const SizedBox(height: 40),
              _buildSignInButton(),
              const SizedBox(height: 10),
              const LinkLabel(),
              if (_errorMessage.isNotEmpty) ...[
                const SizedBox(height: 10),
                Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

// 이메일 입력 필드 위젯
  Widget _buildEmailInput() {
    return LoginTextInput(
      label: '이메일',
      controller: _emailController,
    );
  }

  // 비밀번호 입력 필드 위젯
  Widget _buildPasswordInput() {
    return LoginTextInput(
      label: '비밀번호',
      controller: _passwordController,
    );
  }

  // 로그인 버튼 위젯
  Widget _buildSignInButton() {
    return LoginButton(
      label: '로그인',
      onPressed: _login,
    );
  }
}