import 'package:flutter/material.dart';

class MainTextInput extends StatefulWidget {
  final String label;
  final bool showIcon;
  final bool showRequest;
  final bool showCheck;


  const MainTextInput({
    super.key,
    required this.label,
    required this.showIcon,
    required this.showRequest,
    required this.showCheck,
  });

  @override
  _MainTextInputState createState() => _MainTextInputState();
}

class _MainTextInputState extends State<MainTextInput> {
  bool isVisible = true;

  void toggleVisibility() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 50,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD5D5D5)), // 테두리 색상
        color: Colors.white, // 배경색
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              widget.label,
              style: const TextStyle(
                fontSize: 20,
                color: Color(0xFF595959), // 글자 색상
              ),
            ),
          ),
          if (widget.showRequest)
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFD6D6D6), // 인증 요청 색상
                borderRadius: BorderRadius.circular(50),
              ),
              width: 100,
              height: 30,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(right: 15),
              child: const Text(
                '인증요청',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF595959), // 글자 색상
                ),
              ),
            ),
          if (widget.showCheck)
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFD6D6D6), // 인증 확인 색상
                borderRadius: BorderRadius.circular(50),
              ),
              width: 100,
              height: 30,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(right: 15),
              child: const Text(
                '인증확인',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF595959), // 글자 색상
                ),
              ),
            ),
          if (widget.showIcon)
            IconButton(
              onPressed: toggleVisibility,
              icon: isVisible
                  ? const Icon(Icons.visibility) // 보이는 아이콘
                  : const Icon(Icons.visibility_off), // 숨기는 아이콘
              padding: const EdgeInsets.only(right: 15),
            ),
        ],
      ),
    );
  }
}
