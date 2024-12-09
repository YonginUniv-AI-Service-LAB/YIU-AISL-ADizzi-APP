import 'package:flutter/material.dart';

class ItemPopupMenu extends StatelessWidget {
  final Function(int) onSelected;
  const ItemPopupMenu({Key? key, required this.onSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      color: Colors.white, // 팝업 메뉴 배경색
      offset: const Offset(0, 40), // 팝업 메뉴 위치
      icon: const Icon(Icons.more_vert, color: Colors.black), // 메뉴 아이콘
      onSelected: onSelected, // 선택 콜백
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // 팝업 메뉴 둥근 모서리
      ),
      itemBuilder: (BuildContext context) {
        return [
          // 수정 메뉴 항목
          const PopupMenuItem<int>(
            height: 40,
            value: 0,
            child: Row(
              children: [
                Icon(Icons.edit_note, color: Colors.black),
                SizedBox(width: 8),
                Text(
                  '수정',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const PopupMenuItem<int>(
            height: 40,
            value: 1,
            child: Row(
              children: [
                Icon(Icons.drive_file_move_outline, color: Colors.black),
                SizedBox(width: 8),
                Text(
                  '이동',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const PopupMenuDivider(), // 메뉴 구분선
          // 삭제 메뉴 항목
          const PopupMenuItem<int>(
            height: 40,
            value: 2,
            child: Row(
              children: [
                Icon(Icons.delete_outlined, color: Colors.red),
                SizedBox(width: 8),
                Text(
                  '삭제',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ];
      },
    );
  }
}
