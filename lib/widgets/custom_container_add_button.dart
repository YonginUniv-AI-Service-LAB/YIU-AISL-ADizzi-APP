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

    double width = MediaQuery.of(context).size.width;


    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:backgroundColor,
        fixedSize: Size(width * 0.15, width * 0.04),
      ),
      onPressed: onPressed,
      child: const Center(
        child: Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
      )


    );
  }
}
