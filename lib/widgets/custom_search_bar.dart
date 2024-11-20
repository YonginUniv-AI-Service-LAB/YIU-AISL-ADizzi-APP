import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final VoidCallback onTap;

  CustomSearchBar({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0x80D6D6D6),
         
            borderRadius: BorderRadius.circular(28.0),
          ),
          child: Row(
            children: [
              Icon(
                Icons.search,
                color: Color(0xFF49454F),
              ),
              SizedBox(width: 8.0),
              Text(
                '검색',
                style: TextStyle(color: Color(0xFF49454F)),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
        ),
      ),
    );
  }
}
