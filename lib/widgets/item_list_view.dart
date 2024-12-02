import 'dart:io';
import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/models/item_model.dart';
import 'package:yiu_aisl_adizzi_app/widgets/custom_popup_menu.dart';

class ItemListView extends StatelessWidget {
  final List<ItemModel> items;
  final Function(int) onItemTap;
  final Function(int, bool) onCheckboxChanged; // 체크박스 상태 변경 콜백 추가
  final Function(int) onPopupMenuSelected; // 팝업 메뉴 선택 콜백 추가
  final bool isAllChecked; // 전체 선택 상태
  final Function(bool?) onSelectAllChanged; // 전체 선택 상태 변경 콜백

  const ItemListView({
    Key? key,
    required this.items,
    required this.onItemTap,
    required this.onCheckboxChanged, // 콜백 추가
    required this.onPopupMenuSelected, // 팝업 메뉴 콜백 추가
    required this.isAllChecked, // 전체 선택 상태 추가
    required this.onSelectAllChanged, // 전체 선택/해제 콜백 추가
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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15), // 둥근 테두리
        color: Colors.white, // 배경색 설정
      ),
      margin: const EdgeInsets.all(10), // 컨테이너 외부 여백
      child: Column(
        children: [
          // 전체 선택 체크박스 추가
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Row(
              children: [
                Checkbox(
                  value: isAllChecked, // 전체 선택 상태
                  onChanged: onSelectAllChanged, // 전체 선택 상태 변경
                  activeColor: Color(0xFF5DDA6F),
                  side: BorderSide(
                    color: Colors.grey, // 체크박스의 테두리 색상
                    width: 1, // 테두리 두께
                  ),
                ),
                const Text('전체 선택'),
              ],
            ),
          ),

          // Divider(
          //   color: Color(0xFFF0F0F0), // 구분선 색상 설정
          //   thickness: 2.5, // 구분선 두께 설정
          // ),

          // 아이템 리스트
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return GestureDetector(
                  onTap: () => onItemTap(index), // 아이템 클릭 이벤트
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 3.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, // 항목 간 간격을 최대로
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
                        // 이미지 표시 (이미지 경로가 항상 존재)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(2),
                          child: Image.file(
                            File(item.imagePath!),
                            width: 75,
                            height: 75,
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
                        // CustomPopupMenu (오른쪽에 배치)
                        CustomPopupMenu(
                          onSelected: (value) {
                            onPopupMenuSelected(value); // 팝업 메뉴에서 선택한 항목 처리
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
