import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LogoImage extends StatelessWidget {
  const LogoImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 4,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const CircleAvatar(
        radius: 75,
        backgroundImage: AssetImage('assets/images/ADizziLogo.png'),
        backgroundColor: Colors.white,
      ),
    );
  }
}
