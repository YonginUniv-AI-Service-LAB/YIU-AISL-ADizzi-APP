import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../service/user/mail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainTextInput extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final Widget? child;

  const MainTextInput({
    super.key,
    required this.label,
    required this.controller,
    this.child,
  });

  @override
  _MainTextInputState createState() => _MainTextInputState();
}

class _MainTextInputState extends State<MainTextInput> {
  bool isVisible = true;

  @override
  void initState() {
    isVisible = widget.child == null ? true : false;
    super.initState();
  }

  //메일 인증 검증 함수 호출
  void _mail() async {
    final String email = widget.controller.text;
    try {
      final response = await mail(email);
      print('Response body: ${response.body}');

      switch (response.statusCode) {
        case 200:
          print('코드 전송 성공');
          final code = response.body;
          print('인증 코드: $code');

          // 인증 코드를 SharedPreferences에 저장
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('auth_code', code);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('인증 코드가 전송되었습니다.')),
          );
          break;
        case 400:
          print('입력된 이메일이 비어있습니다.');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('이메일을 입력해주세요.')),
          );
          break;
        case 404:
          print('이메일 주소를 찾을 수 없습니다.');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('등록된 이메일이 아닙니다.')),
          );
          break;
        case 500:
          print('서버 오류');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('서버 오류가 발생했습니다. 다시 시도해주세요.')),
          );
          break;
        default:
          print('알 수 없는 오류: ${response.statusCode}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('알 수 없는 오류가 발생했습니다.')),
          );
          break;
      }
    } catch (e) {
      print('예외 발생: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('서버와의 연결에 실패했습니다. 다시 시도해주세요.')),
      );
    }
  }

  // 인증 확인 함수
  void _verifyCode() async {
    final String inputCode = widget.controller.text;

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
    if (inputCode == storedCode) {
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
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;

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
                    obscureText: isVisible,
                    decoration: InputDecoration(
                      hintText: widget.label, // hintText로 레이블 대체
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
              widget.child ??
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