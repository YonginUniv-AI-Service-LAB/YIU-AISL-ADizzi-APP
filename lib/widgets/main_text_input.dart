import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../service/user/mail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainTextInput extends StatefulWidget {
  final String label;
  final bool showIcon;
  final bool showRequest;
  final bool showCheck;
  final TextEditingController controller;

  const MainTextInput({
    super.key,
    required this.label,
    required this.showIcon,
    required this.showRequest,
    required this.showCheck,
    required this.controller,
  });

  @override
  _MainTextInputState createState() => _MainTextInputState();
}

class _MainTextInputState extends State<MainTextInput> {
  final TextEditingController _emailController = TextEditingController();

  bool isVisible = true;
  String _errorMessage = '';

    void _mail() async {
      final String email = widget.controller.text;

      if (email.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('이메일을 입력해주세요.')),
        );
        return;
      }

      try {
        final response = await mail(email);
        final errorResponse = jsonDecode(utf8.decode(response.bodyBytes));

        print('Response body: ${response.body}');

        if (response.statusCode == 200) {
          final code = response.body;
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('auth_code', code);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('인증 코드가 전송되었습니다.')),
          );
        }  else if (errorResponse['code'] == "E502") {
          _setError('이미 사용 중인 이메일입니다.');
        } else if (errorResponse['code'] == "E701") {
          _setError('비밀번호가 일치하지 않습니다..');
        } else if (response.statusCode == 404) {
          _setError('이메일이 존재하지 않습니다.');
        } else {
          _setError('로그인 실패. 다시 시도해주세요.');
        }
      }catch (e) {
        print('예외 발생: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('서버와의 연결에 실패했습니다. 다시 시도해주세요.')),
        );
      }
    }

  // 에러 메시지 설정
  void _setError(String message) {
    setState(() {
      _errorMessage = message;
    });
  }
// 인증 확인 함수
  void _verifyCode() async {
    final String code = widget.controller.text;

    if (code.isEmpty) {
      // 인증번호가 비어 있을 경우
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('인증번호를 입력해주세요.')),
      );
      return;  // 코드 입력이 없으면 함수 종료
    }

    // 로컬 저장소에서 인증 코드 가져오기
    final prefs = await SharedPreferences.getInstance();
    final storedCode = prefs.getString('auth_code');

    if (storedCode == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('인증 코드가 저장되지 않았습니다.')),
      );
      return;
    }

    // 입력된 코드와 저장된 코드 비교
    if (code == storedCode) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('인증 성공!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('인증 코드가 일치하지 않습니다.')),
      );
    }
  }


  void toggleVisibility() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    double buttonWidth = width * 0.22;
    double padding = width * 0.04;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: height * 0.055,
          margin: EdgeInsets.only(bottom: width * 0.03),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFD5D5D5)),
            color: Colors.white,
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: padding),
                  child: TextField(
                    controller: widget.controller,
                    obscureText: widget.label == '비밀번호' || widget.label == '비밀번호 재입력' ? !isVisible : false,
                    decoration: InputDecoration(
                      hintText:  widget.label, // hintText로 레이블 대체
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFF595959),
                    ),
                    maxLines: 1,
                  ),
                ),
              ),

              if (widget.showRequest)
                Padding(
                  padding: EdgeInsets.only(right: padding),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD6D6D6),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      minimumSize: Size(buttonWidth, 28),
                    ),
                    onPressed: _mail,
                    child: const Text(
                      '인증요청',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color(0xFF595959),
                      ),
                    ),
                  ),
                ),
              if (widget.showCheck)
                Padding(
                  padding: EdgeInsets.only(right: padding),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD6D6D6),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      minimumSize: Size(buttonWidth, 28),
                    ),
                    onPressed: _verifyCode, // 인증 확인 버튼에 함수 연결
                    child: const Text(
                      '인증확인',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color(0xFF595959),
                      ),
                    ),
                  ),
                ),
              if (widget.showIcon)
                Padding(
                  padding: EdgeInsets.only(right: padding),
                  child: IconButton(
                    onPressed: toggleVisibility,
                    icon: isVisible
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}