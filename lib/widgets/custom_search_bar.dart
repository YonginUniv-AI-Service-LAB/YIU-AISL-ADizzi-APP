import 'package:flutter/material.dart';

import '../screens/search/search_screen.dart';

class CustomSearchBar extends StatelessWidget {
  final VoidCallback onTap;

  CustomSearchBar({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchScreen()),
            );
          },
          borderRadius: BorderRadius.circular(28.0), // Ensure the ripple effect matches the container's radius
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0x80D6D6D6),
              borderRadius: BorderRadius.circular(28.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchScreen()),
                    );
                  },
                  icon: const Icon(Icons.search),
                ),
                const SizedBox(width: 8.0),
                const Text(
                  '검색',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
