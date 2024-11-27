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

  //회원가입 검증 함수 호출
  void _signUp() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    try {
      final response = await signUp(email, password);

      //이메일, 비밀번호 필수 입력 값
      if (response.statusCode == 200) {
        print('회원가입 성공');
        _navigateToSignIn();
      } else if(response.statusCode == 400){
        print('이미 사용 중인 이메일입니다.');
      } else if(response.statusCode == 500){
        print('데이터 미입력');
      } else{
        print('문제가 발생했습니다.');
      }
    } catch (e) {
      print('회원가입 중 오류 발생: $e');
    }
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

