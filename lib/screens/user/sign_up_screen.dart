import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yiu_aisl_adizzi_app/service/user_service.dart';
import '../../service/user/signUp.dart';
import '../../service/service.dart';
import '../../widgets/main_button.dart';
import '../../widgets/main_text_input.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  //회원가입 검증 함수 호출
  void _signUp() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;
    final String confirmPassword = _confirmPasswordController.text;
    final String code = _codeController.text;

    // 비밀번호와 비밀번호 재입력 체크
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('비밀번호가 일치하지않습니다. 다시 입력해주세요.')),
      );
      return; // 비밀번호가 일치하지 않으면 함수 종료
    }

    // 인증 코드 확인
    final prefs = await SharedPreferences.getInstance();
    final storedCode = prefs.getString('auth_code');

    if (storedCode == null || code.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('인증 코드를 입력해주세요.')),
      );
      return;
    }

    if (code != storedCode) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('인증 코드가 일치하지 않습니다.')),
      );
      return;
    }

    try {
      await signUp(context, email: email, password: password);
    } catch (e) {
      print('회원가입 중 오류 발생: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$e')),
      );
      return;
    }
    _navigateToSignIn();
  }


  // 회원가입 성공 시 화면 전환 함수
  void _navigateToSignIn() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
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
                        const SizedBox(height: 5),
                        _buildCodeInput(),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 40),
                    child: Column(
                      children: [
                        _buildPwdInput(),
                        const SizedBox(height: 5),
                        _buildConfirmPwdInput(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  MainButton(
                    label: '회원가입',
                    onPressed: () {
                      _signUp();
                    },
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
  Widget _buildEmailInput(){
    return MainTextInput(
      label: '이메일',
      controller: _emailController,
      showCheck: false,
      showRequest: true,
      showIcon: false,
    );
  }

  // 인증번호 입력 필드 위젯
  Widget _buildCodeInput(){
    return MainTextInput(
      label: '인증번호',
      controller: _codeController,
      showCheck: true,
      showRequest: false,
      showIcon: false,
    );
  }

  // 비밀번호 입력 필드 위젯
  Widget _buildPwdInput(){
    return MainTextInput(
      label: '비밀번호',
      controller: _passwordController,
      showCheck: false,
      showRequest: false,
      showIcon: true,
    );
  }

  // 비밀번호 재입력 입력 필드 위젯
  Widget _buildConfirmPwdInput(){
    return MainTextInput(
      label: '비밀번호 재입력',
      controller: _confirmPasswordController,
      showCheck: false,
      showRequest: false,
      showIcon: true,
    );
  }

}