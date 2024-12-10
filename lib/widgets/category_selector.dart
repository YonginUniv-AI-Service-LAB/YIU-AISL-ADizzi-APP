import 'package:flutter/material.dart';

class CategorySelector extends StatelessWidget {
  final String? selectedCategory; // 선택된 카테고리 (대분류 또는 소분류)
  final String label; // 카테고리 라벨 (대분류/소분류)
  final VoidCallback onPressed; // 선택 버튼을 눌렀을 때 실행되는 콜백 함수

  const CategorySelector({
    Key? key,
    required this.selectedCategory,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        TextButton(
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
                style: TextStyle(
                  fontSize: 14,
                  color: selectedCategory == null ? Colors.grey : Colors.black,
                ),
              ),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ],
    );
  }
}
