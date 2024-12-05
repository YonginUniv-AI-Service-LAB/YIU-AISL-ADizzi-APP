import 'package:flutter/material.dart';

class MailButton extends StatelessWidget {
  final String title; // 버튼에 표시할 텍스트
  final VoidCallback onPressed; // 버튼 클릭 시 호출될 함수

  const MailButton({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

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

    return Padding(
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
        onPressed: onPressed, // 인증 확인 버튼에 함수 연결
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: Color(0xFF595959),
          ),
        ),
      ),
    );
  }
}
