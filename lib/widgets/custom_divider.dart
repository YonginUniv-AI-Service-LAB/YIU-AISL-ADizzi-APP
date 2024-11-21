import 'package:flutter/material.dart';
import 'custo_popup_menu.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      margin: const EdgeInsets.all(10),
      child: Column(
        children: roomData.map((room) {
          return Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero, // 기본 패딩 제거
                title: Padding(
                  padding: const EdgeInsets.only(left: 13.0),
                  child: Text(
                    room['text']!,
                    style: const TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
                trailing: CustomPopupMenu(
                  onSelected: (int result) {
                    if (result == 0) {
                      // 수정 선택
                    } else if (result == 1) {
                      // 삭제 선택
                    }
                  },
                ),
                onTap: () {},
              ),
              const Divider(
                color: Color(0x80D6D6D6),
                thickness: 1.5,
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

final roomData = [
  {'text': '거실'},
  {'text': '부엌'},
  {'text': '방1'},
  {'text': '방2'},
  {'text': '방3'},
];
