import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const MainButton({
    super.key,
    required this.label,
    required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return GestureDetector( // 클릭을 감지할 GestureDetector 사용
      onTap: onPressed, // onPressed 콜백 호출
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF5DDA6F), // 배경색
          borderRadius: BorderRadius.circular(10), // 모서리 둥글게
        ),
        width: MediaQuery.of(context).size.width * 0.9, // 너비를 화면의 90%로 설정
        height: 50, // 높이 설정
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white, // 글자색
            ),
          ),
        ),
      ),
    );
  }
}
