import 'package:flutter/material.dart';

class CustomPopupMenu extends StatelessWidget {
  const CustomPopupMenu({super.key, required this.onSelected});

  final Function(int) onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      color: Colors.white,
      popUpAnimationStyle: AnimationStyle.noAnimation,

      offset: const Offset(50, 50), // 팝업 메뉴 위치 변경
      icon: const Icon(Icons.more_vert, color: Colors.black),
      onSelected: onSelected,
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<int>(
            height: 30,
            value: 0,
            child: Container(

              child: const Row(
                children: [
                  Icon(Icons.edit_note, color: Colors.black),
                  SizedBox(width: 8),
                  Text('수정', style: TextStyle(color: Colors.black)),
                ],
              ),
            ),
          ),
          const PopupMenuDivider(),
          // 삭제 메뉴 항목
          PopupMenuItem<int>(
            height: 30,
            value: 1,
            child: Container(
              child: const Row(
                children: [
                  Icon(Icons.delete_outlined, color: Colors.red),
                  SizedBox(width: 8),
                  Text('삭제', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ),
        ];
      },
    );
  }
}
