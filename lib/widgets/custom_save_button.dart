import 'package:flutter/material.dart';

class CustomSaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomSaveButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        '저장',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF5DDA6F),
        minimumSize: Size(double.infinity, 50),
      ),
    );
  }
}
