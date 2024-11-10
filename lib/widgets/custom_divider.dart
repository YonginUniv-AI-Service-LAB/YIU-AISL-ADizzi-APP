import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50), // 전체 컨테이너의 둥근 모서리
      child: Container(
        color: Colors.white, // 전체 배경 색상
        margin: const EdgeInsets.all(10), // 전체 여백 설정
        child: Column(
          children: roomData.map((room) {
            return Column(
              children: [
                ListTile(
                  title: Text(
                    room['text']!,
                    style: const TextStyle(color: Colors.black),
                  ),
                  trailing: const Icon(Icons.more_vert),
                  onTap: () {
                    // 탭을 눌렀을 때의 액션
                  },
                ),
                const Divider(
                  color: Color(0xFFD6D6D6),
                  thickness: 2,
                ),
              ],
            );
          }).toList(),
        ),
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
