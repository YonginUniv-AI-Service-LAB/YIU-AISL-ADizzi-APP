import 'package:flutter/material.dart';

class LoginTextInput extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const LoginTextInput({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    double containerWidth = width * 0.9;
    double containerHeight = height * 0.05;
    double padding = width * 0.04;

    return Container(
      width: containerWidth,
      height: containerHeight,
      margin: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: padding),
              child: TextField(
                controller: controller,  // controller 전달
                decoration: InputDecoration(
                  hintText: label, // hintText로 레이블 대체
                  border: InputBorder.none,  // 테두리 없애기
                ),
                style: const TextStyle(
                  fontSize: 15,
                ),
                maxLines: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
