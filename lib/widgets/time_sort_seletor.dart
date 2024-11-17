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
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: onLatestTap,
            child: Text(
              '최신등록순',
              style: TextStyle(
                color: isLatestSelected ? Color(0xFF5DDA6F) : Color(0xFF595959),
              ),
            ),
          ),

          const SizedBox(width: 5),
          const Text(
            '/',
            style: TextStyle(
              color: Color(0xFF595959),
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(width: 5),

          GestureDetector(
            onTap: onOldestTap,
            child: Text(
              '오래된순',
              style: TextStyle(
                color: !isLatestSelected ? Color(0xFF5DDA6F) : Color(0xFF595959),
              ),
            ),
          ),
          const Icon(Icons.swap_vert, color: Color(0xFF595959),),
        ],
      ),
    );
  }
}