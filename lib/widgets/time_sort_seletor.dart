import 'package:flutter/material.dart';

class TimeSortSelector extends StatelessWidget {
  final bool isLatestSelected;
  final VoidCallback onLatestTap;
  final VoidCallback onOldestTap;

  const TimeSortSelector({
    Key? key,
    required this.isLatestSelected,
    required this.onLatestTap,
    required this.onOldestTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 0.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: onLatestTap,
            child: Text(
              '최신등록순',
              style: TextStyle(
                color: isLatestSelected ? Color(0xFF5DDA6F) : Color(0xFF595959),
                fontWeight: FontWeight.w500,
                fontSize: 13,  // 폰트 크기 설정
              ),
            ),
          ),
          const SizedBox(width: 3),
          const Text(
            '/',
            style: TextStyle(
              color: Color(0xFF595959),
              fontWeight: FontWeight.w500,
              fontSize: 13,  // 폰트 크기 설정
            ),
          ),
          const SizedBox(width: 3),
          GestureDetector(
            onTap: onOldestTap,
            child: Text(
              '오래된순',
              style: TextStyle(
                color: !isLatestSelected ? Color(0xFF5DDA6F) : Color(0xFF595959),
                fontWeight: FontWeight.w500,
                fontSize: 13,  // 폰트 크기 설정
              ),
            ),
          ),
          const Icon(
            Icons.swap_vert,
            color: Color(0xFF595959),
            size: 18,  // 아이콘 크기 조정 (필요시)
          ),
        ],
      ),
    );
  }
}
