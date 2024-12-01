import 'dart:io';
import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/models/item_model.dart';

class ItemListView extends StatelessWidget {
  final List<ItemModel> items;
  final Function(int) onItemTap;
  final Function(int, bool) onCheckboxChanged; // 체크박스 상태 변경 콜백 추가

  const ItemListView({
    Key? key,
    required this.items,
    required this.onItemTap,
    required this.onCheckboxChanged, // 콜백 추가
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 아이템이 없을 경우 메시지 표시
    if (items.isEmpty) {
      return const Center(
        child: Text(
          '추가된 물건이 없습니다.',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    // 아이템이 있을 경우
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return GestureDetector(
          onTap: () => onItemTap(index), // 아이템 클릭 이벤트
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
            child: Row(
              children: [
                // 체크박스 (왼쪽에 배치)
                Checkbox(
                  value: item.isChecked, // 체크 여부
                  onChanged: (bool? value) {
                    // 체크박스 상태 변경 시 콜백 호출
                    onCheckboxChanged(index, value ?? false);
                  },
                  activeColor: Color(0xFF5DDA6F),
                  side: BorderSide(
                    color: Colors.grey, // 체크박스의 테두리 색상
                    width: 1, // 테두리 두께
                  ),
                ),
                // const SizedBox(width: 1), // 체크박스와 이미지 간 간격
                // 이미지 표시 (이미지 경로가 항상 존재)
                ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: Image.file(
                    File(item.imagePath!),
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16), // 이미지와 이름 간 간격
                // 아이템 이름 표시
                Expanded(
                  child: Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis, // 이름이 길어지면 생략 표시
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
