import 'dart:io';
import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/models/item_model.dart';
import 'package:yiu_aisl_adizzi_app/screens/item/add_items.dart';
import 'package:yiu_aisl_adizzi_app/widgets/custom_popup_menu.dart';

class ItemListView extends StatefulWidget {
  final List<ItemModel> items;
  final Function(int) onItemTap;
  final Function(int, bool) onCheckboxChanged; // 체크박스 상태 변경 콜백 추가
  final bool isAllChecked; // 전체 선택 상태
  final Function(bool?) onSelectAllChanged; // 전체 선택 상태 변경 콜백
  final VoidCallback onDeleteSelected; // 선택된 항목 삭제 콜백 추가

  const ItemListView({
    Key? key,
    required this.items,
    required this.onItemTap,
    required this.onCheckboxChanged, // 콜백 추가
    required this.isAllChecked, // 전체 선택 상태 추가
    required this.onSelectAllChanged, // 전체 선택/해제 콜백 추가
    required this.onDeleteSelected, // 선택된 항목 삭제 콜백
  }) : super(key: key);

  @override
  _ItemListViewState createState() => _ItemListViewState();
}

class _ItemListViewState extends State<ItemListView> {
  // 팝업 메뉴 동작 처리
  void _handlePopupMenuAction(int index, int action) {
    if (action == 0) {
      // 수정 동작
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddItemsPage(
            item: widget.items[index], // 선택된 항목 정보 전달
          ),
        ),
      ).then((updatedItem) {
        if (updatedItem != null) {
          setState(() {
            widget.items[index] = updatedItem; // 수정된 항목으로 갱신
          });
        }
      });
    } else if (action == 1) {
      // 삭제 동작
      setState(() {
        widget.items.removeAt(index); // 리스트에서 항목 제거
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) {
      return const Center(
        child: Text(
          '추가된 물건이 없습니다.',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15), // 둥근 테두리
        color: Colors.white, // 배경색 설정
      ),
      margin: const EdgeInsets.all(10), // 컨테이너 외부 여백
      child: Column(
        children: [
          // 전체 선택 체크박스 및 선택 삭제 버튼 추가
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: widget.isAllChecked, // 전체 선택 상태
                      onChanged: widget.onSelectAllChanged, // 전체 선택 상태 변경
                      activeColor: const Color(0xFF5DDA6F),
                      side: const BorderSide(
                        color: Colors.grey, // 체크박스의 테두리 색상
                        width: 1, // 테두리 두께
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
                // 선택 삭제 버튼
                TextButton(
                  onPressed: widget.onDeleteSelected, // 선택 삭제 로직 호출
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
          ),

          // 아이템 리스트
          Expanded(
            child: ListView.builder(
              itemCount: widget.items.length,
              itemBuilder: (context, index) {
                final item = widget.items[index];
                return GestureDetector(
                  onTap: () => widget.onItemTap(index), // 아이템 클릭 이벤트
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5.0,
                      horizontal: 3.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, // 항목 간 간격을 최대로
                      children: [
                        // 체크박스 (왼쪽에 배치)
                        Checkbox(
                          value: item.isChecked, // 체크 여부
                          onChanged: (bool? value) {
                            // 체크박스 상태 변경 시 콜백 호출
                            widget.onCheckboxChanged(index, value ?? false);
                          },
                          activeColor: const Color(0xFF5DDA6F),
                          side: const BorderSide(
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
                            _handlePopupMenuAction(index, value); // 팝업 메뉴 처리
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
