import 'package:flutter/material.dart';

class SelectAllBar extends StatelessWidget {
  final bool isAllChecked;
  final Function(bool?) onSelectAllChanged;
  final VoidCallback onDeleteSelected;

  const SelectAllBar({
    Key? key,
    required this.isAllChecked,
    required this.onSelectAllChanged,
    required this.onDeleteSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Checkbox(
                value: isAllChecked,
                onChanged: onSelectAllChanged,
                activeColor: const Color(0xFF5DDA6F),
                side: const BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              const Text(
                '전체 선택',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: onDeleteSelected,
            child: const Text(
              '선택 삭제',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
