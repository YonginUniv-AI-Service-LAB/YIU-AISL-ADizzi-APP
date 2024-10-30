import 'package:flutter/material.dart';

class SignInTextInput extends StatelessWidget {
  final String label;

  const SignInTextInput({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8, // 화면 너비의 80%
      height: 46,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white, // 흰색 배경
        borderRadius: BorderRadius.circular(10),

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16, // 필요에 따라 글자 크기 조정
              ),
            ),
          ),
        ],
      ),
    );
  }
}
