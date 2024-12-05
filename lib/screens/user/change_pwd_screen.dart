import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yiu_aisl_adizzi_app/service/user_service.dart';
import 'package:yiu_aisl_adizzi_app/widgets/mail_button.dart';
import '../../service/user/signUp.dart';
import '../../service/service.dart';
import '../../widgets/main_button.dart';
import '../../widgets/main_text_input.dart';
import 'login_screen.dart';

class ChangePwdScreen extends StatefulWidget {
  @override
  _ChangePwdScreenState createState() => _ChangePwdScreenState();
}

class _ChangePwdScreenState extends State<ChangePwdScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  late String authCode;
  bool isConfirmedMail = false;

  //회원가입 검증 함수 호출
  void _signUp() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;
    final String confirmPassword = _confirmPasswordController.text;

    // 비밀번호와 비밀번호 재입력 체크
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('비밀번호가 일치하지않습니다. 다시 입력해주세요.')),
      );
      return; // 비밀번호가 일치하지 않으면 함수 종료
    }

    if (!isConfirmedMail){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('인증된 이메일이 아닙니다. 이메일 인증을 해주세요')),
      );
      return;
    }

    await changePassword(context, email: email, password: password);
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
          '비밀번호 재설정',
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
                        MainTextInput(
                          label: '이메일',
                          controller: _emailController,
                          child: MailButton(
                            title: '인증요청',
                            onPressed: () async{
                              authCode = await sendMail(context, email: _emailController.text);
                            },
                          ),
                        ),
                        const SizedBox(height: 5),
                        MainTextInput(
                          label: '인증번호',
                          controller: _codeController,
                          child: MailButton(
                            title: '인증요청',
                            onPressed: () async{
                              final String inputCode = _codeController.text;

                              if (authCode == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('인증 코드가 저장되지 않았습니다.')),
                                );
                                return;
                              }

                              // 입력된 코드와 저장된 코드 비교
                              if (inputCode == authCode) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('인증 성공!')),
                                );
                                isConfirmedMail = true;
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('인증 코드가 일치하지 않습니다.')),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 40),
                    child: Column(
                      children: [
                        MainTextInput(
                          label: '비밀번호',
                          controller: _passwordController,
                        ),
                        const SizedBox(height: 5),
                        MainTextInput(
                          label: '비밀번호 재입력',
                          controller: _confirmPasswordController,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  MainButton(
                    label: '비밀번호 재설정',
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

}