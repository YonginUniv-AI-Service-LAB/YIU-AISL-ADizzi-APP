import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const MainButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;



    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF5DDA6F),
        elevation: 4,
        fixedSize: Size(width * 0.9, height * 0.04),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.white, // Text color
        ),
      ),
    );
  }
}
