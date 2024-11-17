import 'package:flutter/material.dart';

class SignInTextInput extends StatelessWidget {
  final String label;

  const SignInTextInput({super.key, required this.label});

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    double containerWidth = width * 0.8;
    double containerHeight = height * 0.04;
    double padding = width * 0.05;

    return Container(
      width: containerWidth,
      height: containerHeight,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: padding),
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
