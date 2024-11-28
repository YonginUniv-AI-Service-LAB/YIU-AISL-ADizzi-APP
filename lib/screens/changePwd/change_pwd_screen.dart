import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/screens/login/login_screen.dart';
import 'package:yiu_aisl_adizzi_app/utils/token.dart';
import '../../widgets/main_button.dart';
import '../../widgets/main_text_input.dart';
import '../../service/user/change_pwd.dart';

class ChangePwd extends StatefulWidget {
  const ChangePwd({super.key});

  @override
  _ChangePwdState createState() => _ChangePwdState();
}

class _ChangePwdState extends State<ChangePwd> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // 비밀번호 변경 검증 함수 호출
  void _changePwd() async {
    final String email = _emailController.text;
    final String password = _newPasswordController.text;

    try {
      final token = await getToken();
      final response = await changePwd(email, password, token!);

      if (response.statusCode == 200) {
        print('비밀번호 변경 성공');
        _navigateToSignIn();
      } else {
        print('문제가 발생했습니다. 상태 코드: ${response.statusCode}');
        print('응답 본문: ${response.body}');

      }
    } catch (e) {
      print('비밀번호 재설정 중 오류 발생');
    }
  }

  // 비밀번호 변경 성공 시 화면 전환 함수
  void _navigateToSignIn() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '비밀번호 재설정',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFF0F0F0),
      ),
      body: Container(
        color: const Color(0xFFF0F0F0),
        padding: EdgeInsets.all(width * 0.05),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: height * 0.05, top: 15),
              child: Column(
                children: [
                  _buildEmailInput(),
                  const SizedBox(height: 5),
                  _buildCodeInput(),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: height * 0.05),
              child: Column(
                children: [
                  _buildNewPwdInput(),
                  const SizedBox(height: 5),
                  _buildNewConfirmPwdInput(),
                ],
              ),
            ),

            MainButton(
              label: '비밀번호 재설정',
              onPressed: _changePwd,
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

  // 새 비밀번호 입력 필드 위젯
  Widget _buildNewPwdInput(){
    return MainTextInput(
      label: '새 비밀번호 입력',
      controller: _newPasswordController,
      showCheck: false,
      showRequest: false,
      showIcon: true,
    );
  }

  // 새 비밀번호 재입력 입력 필드 위젯
  Widget _buildNewConfirmPwdInput(){
    return MainTextInput(
      label: '새 비밀번호 재입력',
      controller: _confirmPasswordController,
      showCheck: false,
      showRequest: false,
      showIcon: true,
    );
  }
}