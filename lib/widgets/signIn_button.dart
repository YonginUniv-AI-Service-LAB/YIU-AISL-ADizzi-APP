import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const SignInButton({
    super.key,
    required this.label,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.6, // 화면 너비의 60%
        height: 43,
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF5DDA6F), // 초록색 배경
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}