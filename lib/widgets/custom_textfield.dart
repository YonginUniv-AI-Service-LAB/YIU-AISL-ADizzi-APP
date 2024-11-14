import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;

  CustomTextField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), // 세로 길이 조정

        // 테두리 색 변경
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0x8049454F), width: 1), // 비활성 상태에서 테두리 색
          borderRadius: BorderRadius.circular(15.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF49454F), width: 1.5), // 포커스 상태에서 테두리 색
          borderRadius: BorderRadius.circular(15.0),
        ),

      ),
    );
  }
}