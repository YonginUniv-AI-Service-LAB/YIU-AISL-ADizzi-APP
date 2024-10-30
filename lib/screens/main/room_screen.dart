import 'package:flutter/material.dart';
import '../../custom/search_bar.dart.dart';

class Room extends StatelessWidget {
  const Room({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFF0F0F0),
      body: Center(


            child: CustomSearchBar(),


      ),
    );
  }
}
