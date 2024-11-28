import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final int maxLines; // maxLines 추가 (기본값은 1)
  final double fontSize;
  final double height; // 필드 높이 추가

  CustomTextField({
    required this.controller,
    this.maxLines = 1, // 기본값 지정
    this.fontSize = 14.0,
    this.height = 47.0, // 기본 필드 높이
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height, // 크기를 설정
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: TextStyle(
          fontSize: fontSize, // 텍스트 크기
          color: Colors.black,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 16.0,
          ),

          // 테두리 색 변경
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0x8049454F),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF49454F),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
      ),
    );
  }
}
