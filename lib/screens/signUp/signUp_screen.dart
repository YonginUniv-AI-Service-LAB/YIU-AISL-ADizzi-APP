import 'dart:convert';

import 'package:flutter/material.dart';
import '../../service/user/signUp.dart';
import '../../widgets/main_button.dart';
import '../../widgets/main_text_input.dart';
import '../login/login_screen.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}
class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  String _errorMessage = '';

  void _signUp() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;
    final String confirmPassword = _confirmPasswordController.text;
    final String code = _codeController.text;

    // Clear previous error message
    setState(() {
      _errorMessage = '';
    });

    // Validation
    if (email.isEmpty) {
      _setError('이메일을 입력해주세요.');
      return;
    }
    if (password.isEmpty) {
      _setError('비밀번호를 입력해주세요.');
      return;
    }
    if (confirmPassword.isEmpty) {
      _setError('비밀번호를 재입력해주세요.');
      return;
    }
    if (password != confirmPassword) {
      _setError('비밀번호가 일치하지 않습니다.');
      return;
    }
    if (code.isEmpty) {
      _setError('인증번호를 입력해주세요.');
      return;
    }

    // Call the sign-up service
    try {
      final response = await signUp(email, password);
      final errorResponse = jsonDecode(utf8.decode(response.bodyBytes));

      if (errorResponse['code'] == "E502") {
        _setError('이미 사용 중인 이메일입니다.');
      } else if (response.statusCode == 200) {
        _navigateToSignIn();
      } else {
        _setError('알 수 없는 오류가 발생했습니다.');
      }
    } catch (e) {
      _setError('서버와의 연결에 실패했습니다.');
    }
  }


  // 에러 메시지 설정
  void _setError(String message) {
    setState(() {
      _errorMessage = message;
    });
  }

  // 회원가입 성공 시 화면 전환 함수
  void _navigateToSignIn() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      appBar: AppBar(
        title: const Text(
          '회원가입',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFF0F0F0),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 40),
                    child: Column(
                      children: [
                        _buildEmailInput(),
                        _buildCodeInput(),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 40),
                    child: Column(
                      children: [
                        _buildPwdInput(),
                        _buildConfirmPwdInput(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  MainButton(
                    label: '회원가입',
                    onPressed: () {
                      _signUp();
                    },
                  ),
                  if (_errorMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        _errorMessage,
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 이메일 입력 필드 위젯
  Widget _buildEmailInput() {
    return MainTextInput(
      label: '이메일',
      controller: _emailController,
      showCheck: false,
      showRequest: true,
      showIcon: false,
    );
  }

  // 인증번호 입력 필드 위젯
  Widget _buildCodeInput() {
    return MainTextInput(
      label: '인증번호',
      controller: _codeController,
      showCheck: true,
      showRequest: false,
      showIcon: false,
    );
  }

  // 비밀번호 입력 필드 위젯
  Widget _buildPwdInput() {
    return MainTextInput(
      label: '비밀번호',
      controller: _passwordController,
      showCheck: false,
      showRequest: false,
      showIcon: true,
    );
  }

  // 비밀번호 재입력 입력 필드 위젯
  Widget _buildConfirmPwdInput() {
    return MainTextInput(
      label: '비밀번호 재입력',
      controller: _confirmPasswordController,
      showCheck: false,
      showRequest: false,
      showIcon: true,
    );
  }
}
