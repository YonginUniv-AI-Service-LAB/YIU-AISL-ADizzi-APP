import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:yiu_aisl_adizzi_app/models/item_model.dart';
import 'package:yiu_aisl_adizzi_app/screens/item/add_item_screen.dart';
import 'package:yiu_aisl_adizzi_app/screens/item/edit_item_screen.dart';
import 'package:yiu_aisl_adizzi_app/service/item_service.dart';
import 'package:yiu_aisl_adizzi_app/utils/model.dart';
import 'package:yiu_aisl_adizzi_app/widgets/custom_popup_menu.dart';
import 'package:yiu_aisl_adizzi_app/widgets/move_tree.dart';
import 'package:yiu_aisl_adizzi_app/widgets/select_all_bar.dart';
import 'package:yiu_aisl_adizzi_app/widgets/item_row.dart';
import 'package:yiu_aisl_adizzi_app/widgets/item_card.dart';

class ItemListView extends StatefulWidget {
  final List<ItemModel> items;
  final Function(int) onItemTap;
  final Function(int, bool) onCheckboxChanged; // 체크박스 상태 변경 콜백 추가
  final bool isAllChecked; // 전체 선택 상태
  final Function(bool?) onSelectAllChanged; // 전체 선택 상태 변경 콜백
  final VoidCallback onDeleteSelected; // 선택된 항목 삭제 콜백 추가
  final Function loadData; // 선택된 항목 삭제 콜백 추가

  const ItemListView({
    Key? key,
    required this.items,
    required this.onItemTap,
    required this.onCheckboxChanged, // 콜백 추가
    required this.isAllChecked, // 전체 선택 상태 추가
    required this.onSelectAllChanged, // 전체 선택/해제 콜백 추가
    required this.onDeleteSelected, // 선택된 항목 삭제 콜백
    required this.loadData, // 선택된 항목 삭제 콜백
  }) : super(key: key);

  @override
  _ItemListViewState createState() => _ItemListViewState();
}

class _ItemListViewState extends State<ItemListView> {
  // 팝업 메뉴 동작 처리
  void _handlePopupMenuAction(int index, int action) async{
    if (action == 0) {
      // 수정 동작
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              EditItemScreen(
                item: widget.items[index], // 선택된 항목 정보 전달
              ),
        ),
      ).then((_) {widget.loadData();});
    } else if (action == 1) {
      // 이동 동작
      // TODO: 이동할 위치 선택하는 트리 화면 보여주고 선택
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              MoveTree(
                item: widget.items[index], // 선택된 항목 정보 전달
              ),
        ),
      ).then((_) {widget.loadData();});
      print("아이템 이동 요청 itemId: ${widget.items[index].itemId}");
      widget.loadData();
    } else if (action == 2) {
      // TODO: 삭제 동작 (삭제여부 1회 더 물어볼 UI(Dialog) 필요)
      await deleteItem(context, itemId: widget.items[index].itemId);
      widget.loadData();
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
          SelectAllBar(
            isAllChecked: widget.isAllChecked,
            onSelectAllChanged: widget.onSelectAllChanged,
            onDeleteSelected: widget.onDeleteSelected,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.items.length,
              itemBuilder: (context, index) {
                final item = widget.items[index];
                return ItemRow(
                  item: item,
                  index: index,
                  onItemTap: (index) {
                    // 팝업 창 띄우기
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ItemCard(item: item), // 팝업 창으로 띄움
                          ),
                        );
                      },
                    );
                  },
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