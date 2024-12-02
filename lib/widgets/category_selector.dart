import 'package:flutter/material.dart';

class CategorySelector extends StatelessWidget {
  final String? selectedCategory;
  final VoidCallback onPressed;

  const CategorySelector({
    Key? key,
    required this.selectedCategory,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        side: const BorderSide(color: Color(0x8049454F)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            selectedCategory ?? '카테고리 선택',
            style: const TextStyle(fontSize: 14),
          ),
          const Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }
}
