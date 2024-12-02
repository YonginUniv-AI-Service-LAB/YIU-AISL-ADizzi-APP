import 'dart:io';
import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/models/item_model.dart';
import 'package:yiu_aisl_adizzi_app/screens/item/add_items.dart';
import 'package:yiu_aisl_adizzi_app/widgets/custom_popup_menu.dart';
import 'package:yiu_aisl_adizzi_app/widgets/select_all_bar.dart';
import 'package:yiu_aisl_adizzi_app/widgets/item_row.dart';

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
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          // SelectAllBar 위젯
          SelectAllBar(
            isAllChecked: widget.isAllChecked,
            onSelectAllChanged: widget.onSelectAllChanged,
            onDeleteSelected: widget.onDeleteSelected,
          ),
          // ListView.builder
          Expanded(
            child: ListView.builder(
              itemCount: widget.items.length,
              itemBuilder: (context, index) {
                final item = widget.items[index];
                return ItemRow(
                  item: item,
                  index: index,
                  onItemTap: widget.onItemTap,
                  onCheckboxChanged: widget.onCheckboxChanged,
                  onPopupMenuAction: _handlePopupMenuAction,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}