import 'package:flutter/material.dart';

class CustomContainerAddButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final Color backgroundColor;

  const CustomContainerAddButton({
    Key? key,
    required this.onPressed,
    this.icon = Icons.add,
    this.backgroundColor = const Color(0xFF5DDA6F),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: Icon(icon, color: Colors.white, size: 30),
      backgroundColor: backgroundColor,
    );
  }
}